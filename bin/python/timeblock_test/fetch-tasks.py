import orgparse
import pandas as pd
from datetime import datetime
import argparse

# Read command line options using argparse
def parse_arguments():
    parser = argparse.ArgumentParser(description='Extract tasks with their schedule information from an org file.')
    parser.add_argument('filename', type=str, help='The org file to be processed')
    parser.add_argument('--output', '-o', type=str, help='Output CSV file name', default='tasks.csv')
    return parser.parse_args()

# Read the org file using orgparse
def read_org_file(filename):
    tasks = []
    orgfile = orgparse.load(filename)
    
    # Iterate through nodes to find tasks with SCHEDULED property
    for node in orgfile[1:]:  # Skipping the root node
        if node.scheduled:  # Use the scheduled attribute directly
            title = node.heading
            schedule_datetime = node.scheduled.start

            # Extract start and end times for scheduled task
            start_datetime = schedule_datetime
            end_time = None  # Default value if no end time is specified

            # Assume a default duration of 1 hour if not explicitly stated
            end_datetime = start_datetime.replace(hour=start_datetime.hour + 1) if start_datetime.hour < 23 else start_datetime
            end_time = end_datetime.time()

            tasks.append({
                'title': title,
                'start_date': start_datetime.date(),
                'start_time': start_datetime.time(),
                'end_time': end_time
            })
            # Debug: Print task being added
            print(f"Task added: {title}, Start: {start_datetime}, End: {end_time}")
        else:
            # Debug: Print if no scheduled property is found
            print(f"No scheduled date found for node: {node.heading}")
    
    return tasks

# Create tasks table
def create_tasks_table(tasks):
    data = []
    for task in tasks:
        data.append([task['title'], task['start_date'], task['start_time'], task['end_time']])
    columns = ['Title', 'Start Date', 'Start Time', 'End Time']
    return pd.DataFrame(data, columns=columns)

# Main function to tie everything together
def main():
    args = parse_arguments()
    tasks = read_org_file(args.filename)
    tasks_table = create_tasks_table(tasks)
    print(tasks_table)
    # Optionally save to CSV
    tasks_table.to_csv(args.output, index=False)

if __name__ == "__main__":
    main()

