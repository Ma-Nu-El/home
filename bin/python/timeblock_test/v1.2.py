# daybox.py
# Display orgmode SCHEDULED entries in timebox manner.
# Author: Manuel Fuica Morales
# version: 1.2
# Changes from 1.1:
# 1) Parse multiple orgmode files via --agenda-files FILE
#    - default agenda files location: ~/.doom.d/agenda-files.txt
# 2) Accept both DEADLINE and SCHEDULED orgmode entries
# 3) Enable --debug LEVEL option where default LEVEL is DEBUG
# 4) Accept --time-gone option
# 5) Accept --now option to visually show current time in output table

import logging
import argparse
import orgparse
import os
from datetime import datetime, timedelta, date
import re

# Function to parse command line arguments
def parse_arguments():
    parser = argparse.ArgumentParser(description='Process scheduling information from org files.')
    parser.add_argument('--agenda-files', type=str, nargs='?', const='~/.doom.d/agenda-files.txt', help='Path to agenda files list. If no file is provided, default agenda files are used.')
    parser.add_argument('--file', type=str, help='The org file to be processed')
    parser.add_argument('--debug', type=str, nargs='?', const='DEBUG', help='Set the logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL). Default is DEBUG.')
    parser.add_argument('--column-width', '-c', type=int, default=15, help='Width of the columns in the output table')
    parser.add_argument('--detail', '-d', type=str, choices=['hour', 'half', 'quarter'], default='half', help='Detail level for the schedule')
    parser.add_argument('--start', '-s', type=int, default=7, help='Start hour for the schedule')
    parser.add_argument('--end', '-e', type=int, default=21, help='End hour for the schedule')
    parser.add_argument('--date', '-D', type=str, default='today', help='Specify the date to filter tasks: "today", "tomorrow", "yesterday", or "YYYY-MM-DD"')
    parser.add_argument('-v', '--verbose', action='store_true', help='Enable verbose mode to display extra information')
    return parser.parse_args()

# Function to configure logging level based on user input
def configure_logging(level):
    if level:
        levels = {
            'DEBUG': logging.DEBUG,
            'INFO': logging.INFO,
            'WARNING': logging.WARNING,
            'ERROR': logging.ERROR,
            'CRITICAL': logging.CRITICAL
        }
        logging_level = levels.get(level.upper(), logging.DEBUG)
        logging_format = '%(asctime)s - %(levelname)s - %(message)s'
        logging.basicConfig(level=logging_level, format=logging_format)
    else:
        logging.getLogger().setLevel(logging.CRITICAL)  # Disable logging if no --debug argument


# Function to read a list of agenda files
def read_agenda_files(file_path):
    agenda_files = []
    file_path = os.path.expanduser(file_path)  # Expand ~ to the user's home directory
    try:
        with open(file_path, 'r') as f:
            for line in f:
                agenda_file = line.strip()
                if agenda_file and not agenda_file.startswith(';'):
                    agenda_files.append(os.path.expanduser(agenda_file))
                    logging.debug(f"File read: {agenda_file}")
    except FileNotFoundError:
        logging.error(f"Error: File {file_path} not found.")
    return agenda_files

# Function to read tasks from a specific org file
def read_org_file(filename, date_filter):
    logging.debug(f'Reading orgmode file: {filename}')
    tasks = []
    try:
        orgfile = orgparse.load(filename)
        target_date = parse_target_date(date_filter)
        for node in orgfile[1:]:  # Skipping the root node
            if node.scheduled:  # Use the scheduled attribute directly
                title = node.heading
                scheduled_string = re.sub(r'\s\+\d+[ymwd]', '', str(node.scheduled.start))  # Remove any trailing +1y, +6m, etc.
                start_datetime = datetime.strptime(scheduled_string, '%Y-%m-%d %H:%M:%S') if len(scheduled_string) > 10 else datetime.strptime(scheduled_string, '%Y-%m-%d')
                if start_datetime.date() == target_date:
                    end_datetime = node.scheduled.end if node.scheduled.end else (start_datetime + timedelta(hours=1))
                    tasks.append({
                        'title': title,
                        'start_date': start_datetime.date(),
                        'start_time': start_datetime.hour + start_datetime.minute / 60.0,
                        'end_time': end_datetime.hour + end_datetime.minute / 60.0,
                        'type': 'SCHEDULED'
                    })
            if node.deadline:  # Use the deadline attribute directly
                title = node.heading
                deadline_string = re.sub(r'\s-\d+[ymwd]', '', str(node.deadline.start))  # Remove any trailing -1y, -6m, etc.
                start_datetime = datetime.strptime(deadline_string, '%Y-%m-%d %H:%M:%S') if len(deadline_string) > 10 else datetime.strptime(deadline_string, '%Y-%m-%d')
                if start_datetime.date() == target_date:
                    end_datetime = node.deadline.end if node.deadline.end else (start_datetime + timedelta(hours=1))
                    tasks.append({
                        'title': "!" + title,
                        'start_date': start_datetime.date(),
                        'start_time': start_datetime.hour + start_datetime.minute / 60.0,
                        'end_time': end_datetime.hour + end_datetime.minute / 60.0,
                        'type': 'DEADLINE'
                    })
    except FileNotFoundError:
        logging.error(f"Error: File {filename} not found.")
    return tasks

# Function to parse the date from the user input
def parse_target_date(date_filter):
    if date_filter == 'today':
        return date.today()
    elif date_filter == 'tomorrow':
        return date.today() + timedelta(days=1)
    elif date_filter == 'yesterday':
        return date.today() - timedelta(days=1)
    else:
        try:
            return datetime.strptime(date_filter, '%Y-%m-%d').date()
        except ValueError:
            raise ValueError(f"Invalid date format: {date_filter}. Please use 'YYYY-MM-DD'.")

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
        if task_end > end_hour:
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
        header = f"|     | :00{FILL} | :30{FILL} |"
        columns = 3
    elif detail == 'quarter':
        header = f"|     | :00{FILL} | :15{FILL} | :30{FILL} | :45{FILL} |"
        columns = 5
    else:
        raise ValueError("Invalid DETAIL value")

    hline = "|-----" + ('+' + '-' * (column_width )) * (columns - 1) + '|'
    print(header[:len(hline)].ljust(len(hline) - 1, ' '))
    print(hline)

    # Print early tasks count
    if early_tasks > 0:
        # Adjust early task row based on the detail level
        early_left_part = f"|  <{start_hour} | ({early_tasks})".ljust(column_width + 6) + " "
        early_row = early_left_part

        # Adding as many empty columns as needed based on the detail level
        if detail == 'hour':
            columns = 2
        elif detail == 'half':
            columns = 3
        elif detail == 'quarter':
            columns = 5

        # Append empty columns to match the rest of the table
        for _ in range(columns - 2):
            early_row += "|" + " " * (column_width - 1) + " "

        early_row += "|"
        print(early_row[:len(hline)].ljust(len(hline) - 1, ' '))

    # Printing cells in a schedule-like manner (already dynamic)
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
        # Adjust late task row based on the detail level
        late_left_part = f"| >{end_hour} | ({late_tasks})".ljust(column_width + 6) + " "
        late_row = late_left_part

        # Adding as many empty columns as needed based on the detail level
        for _ in range(columns - 2):
            late_row += "|" + " " * (column_width - 1) + " "

        late_row += "|"
        print(late_row[:len(hline)].ljust(len(hline) - 1, ' '))

# Main function to tie everything together
def main():
    args = parse_arguments()
    configure_logging(args.debug)

    logging.debug('Start of program')

    all_tasks = []

    # Read from --agenda-files if provided
    if args.agenda_files:
        agenda_files = read_agenda_files(args.agenda_files)
        for agenda_file in agenda_files:
            all_tasks.extend(read_org_file(agenda_file, args.date))
    elif args.file:
        all_tasks = read_org_file(args.file, args.date)
    else:
        logging.error("Error: You must provide either --agenda-files or --file option.")
        return

    # Print verbose output if enabled
    if args.verbose:
        target_date = parse_target_date(args.date)
        print(f"Daybox for {target_date}")

    cells = create_schedule_cells(args.start, args.end, args.detail, args.column_width)
    cells, early_tasks, late_tasks = assign_tasks_to_cells(all_tasks, cells, args.start, args.end, args.column_width)
    print_schedule_table(cells, args.detail, args.column_width, args.start, args.end, early_tasks, late_tasks)

    logging.debug('End of program')


if __name__ == "__main__":
    main()

