import orgparse
import argparse
from datetime import datetime, timedelta

# Read command line options using argparse
def parse_arguments():
    parser = argparse.ArgumentParser(description='Process scheduling information from an org file.')
    parser.add_argument('filename', type=str, help='The org file to be processed')
    parser.add_argument('--column-width', '-c', type=int, default=15, help='Width of the columns in the output table')
    parser.add_argument('--detail', '-d', type=str, choices=['hour', 'half', 'quarter'], default='half', help='Detail level for the schedule')
    parser.add_argument('--start', '-s', type=int, default=7, help='Start hour for the schedule')
    parser.add_argument('--end', '-e', type=int, default=21, help='End hour for the schedule')
    return parser.parse_args()

# Read the org file using orgparse
def read_org_file(filename):
    tasks = []
    orgfile = orgparse.load(filename)
    for node in orgfile[1:]:  # Skipping the root node
        if node.scheduled:  # Use the scheduled attribute directly
            title = node.heading
            start_datetime = node.scheduled.start
            end_datetime = node.scheduled.end if node.scheduled.end else (start_datetime + timedelta(hours=1))

            tasks.append({
                'title': title,
                'start_date': start_datetime.date(),
                'start_time': start_datetime.hour + start_datetime.minute / 60.0,
                'end_time': end_datetime.hour + end_datetime.minute / 60.0
            })
    return tasks

# Create schedule cells based on detail level
def create_schedule_cells(start_hour, end_hour, detail, column_width):
    if detail == 'hour':
        periods = 1
    elif detail == 'half':
        periods = 2
    elif detail == 'quarter':
        periods = 4
    else:
        raise ValueError("Invalid DETAIL value")
    
    period_length = 1 / periods
    cells = []
    index = 0
    for i in range(end_hour - start_hour):
        for j in range(periods):
            hour = i + start_hour
            minute = period_length * j * 60
            start = hour + (minute / 60)
            end = start + period_length
            cells.append({
                'index': index,
                'hour': hour,
                'minute': minute,
                'start': start,
                'end': end,
                'status': 'free',
                'content': '',
                'count': 0
            })
            index += 1
    return cells

# Associate tasks to schedule cells
def assign_tasks_to_cells(tasks, cells, start_hour, end_hour, column_width):
    early_tasks = 0
    late_tasks = 0
    for task in tasks:
        task_start = task['start_time']
        task_end = task['end_time']
        truncated_title = task['title'][:column_width - 2]

        if task_start < start_hour:
           early_tasks += 1
        if task_start > end_hour:
           late_tasks += 1

        for cell in cells:
            # Check if the task overlaps with the current cell
            if task_start < cell['end'] and task_end > cell['start']:
                if cell['status'] == 'free':
                    if task_start >= cell['start'] and task_start < cell['end']:
                        cell['content'] = f" {truncated_title} ".ljust(column_width - 2)
                        cell['status'] = 'start'
                    else:
                        cell['status'] = 'busy'
                        cell['content'] = f" {'-' * (column_width - 2)} ".ljust(column_width - 2)
                cell['count'] += 1
    return cells, early_tasks, late_tasks

# Print the schedule table
def print_schedule_table(cells, detail, column_width, start_hour, end_hour, early_tasks, late_tasks):
    FILL = " " * (column_width - 5)
    HLINE_SEGMENT = "| " + "-" * (column_width - 2) + " "

    if detail == 'hour':
        header = f"|     | :00{FILL} |"
        columns = 2
    elif detail == 'half':
        header = f"|     | :00{FILL} | :30{FILL} "
        columns = 3
    elif detail == 'quarter':
        header = f"|     | :00{FILL} | :15{FILL} | :30{FILL} | :45{FILL} "
        columns = 5
    else:
        raise ValueError("Invalid DETAIL value")

    hline = "|-----" + ('+' + '-' * (column_width )) * (columns - 1) + '|'
    print(header[:len(hline)].ljust(len(hline) - 1, ' '))
    print(hline)

    # Print early tasks count
    if early_tasks > 0:
       # Asuming the hour column at least ends in
       # a two digits hour like '19'
       # Otherwise, I'd have to parameterize
       #                     ,--- here
       hour_column_left = f"|  <{start_hour} "
       hour_column_right = " "* (len(hour_column_left) - 6)
       hour_column = hour_column_left + hour_column_right
       first_column_left = f"| ({early_tasks}) "
       first_column_right = " " * (column_width - len(first_column_left) + 1)
       first_column = first_column_left + first_column_right
       second_column = "|" + " " * (column_width) + "|"
       early_row = hour_column + first_column + second_column
       print(early_row)



    # Printing cells in a schedule-like manner
    last_hour = None
    row = ''
    for cell in cells:
        if cell['hour'] != last_hour and last_hour is not None:
           print(row[:len(hline)].ljust(len(hline) - 1, ' '))
           row = f"|  {cell['hour']:>2} |"
        elif last_hour is None:
             row = f"|  {cell['hour']:>2} |"

        if cell['status'] == 'free':
           status = f"{' ' * (column_width - 2)}"
        else:
           status = f"{cell['content'].strip()}"
        row += f" {status:<{column_width - 2}} |"
        last_hour = cell['hour']

    if row:
       print(row[:len(hline)].ljust(len(hline) - 1, ' '))

       # Print late tasks count
    if late_tasks > 0:
       # Asuming the end hour is a two digit
       # number so I don't parametrize
       #                     ,--- here
       hour_column_left = f"| <{end_hour-1} "
       hour_column_right = " "* (len(hour_column_left) - 9)
       hour_column = hour_column_left + hour_column_right
       first_column_left = f"| ({late_tasks}) "
       first_column_right = " " * (column_width - len(first_column_left) + 1)
       first_column = first_column_left + first_column_right
       second_column = "|" + " " * (column_width) + "|"
       late_row = hour_column + first_column + second_column
       print(late_row)


# Main function to tie everything together
def main():
    args = parse_arguments()
    tasks = read_org_file(args.filename)
    cells = create_schedule_cells(args.start, args.end, args.detail, args.column_width)
    cells, early_tasks, late_tasks = assign_tasks_to_cells(tasks, cells, args.start, args.end, args.column_width)
    print_schedule_table(cells, args.detail, args.column_width, args.start, args.end, early_tasks, late_tasks)

if __name__ == "__main__":
    main()

