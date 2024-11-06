#!/usr/bin/env python3

import argparse
import re
from datetime import datetime, timedelta
from orgparse import load

def parse_org_timestamp(timestamp):
    """Parse Org mode timestamp to extract start and end times with double hyphen format."""
    match = re.match(r"<(\d{4}-\d{2}-\d{2} \w{3} \d{2}:\d{2})--(\d{2}:\d{2})>", timestamp)
    if match:
        start_str, end_str = match.groups()
        start_time = datetime.strptime(start_str, "%Y-%m-%d %a %H:%M")
        end_time = start_time.replace(hour=int(end_str[:2]), minute=int(end_str[3:]))
        return start_time, end_time
    return None, None

def format_title(title, max_width, add_links=False):
    """Format the title to fit within max_width, adding links if specified."""
    trimmed_title = title[:max_width - 2]
    return f"[[{trimmed_title}]]" if add_links else trimmed_title

def timeblock(org_file, detail, max_col_width, table_start, table_end, links, output_file):
    # Determine intervals per hour based on detail level
    intervals = {'hour': 1, 'half': 2, 'quarter': 4}
    interval_count = intervals[detail]
    
    cell_width = max_col_width + 2  # Add padding to each cell for alignment

    # Initialize table cells as empty strings (no "empty" text)
    table = {hour: [''] * interval_count for hour in range(table_start, table_end + 1)}
    early_tasks, late_tasks = [], []

    # Load Org file and extract tasks with 'SCHEDULED' timestamps
    root = load(org_file)
    for node in root[1:]:  # Skip the root node
        if node.scheduled:
            title = node.heading
            timestamp = str(node.scheduled)
            start_dt, end_dt = parse_org_timestamp(timestamp)

            if start_dt and end_dt:
                if start_dt.hour < table_start:
                    early_tasks.append(title)
                elif end_dt.hour > table_end:
                    late_tasks.append(title)
                else:
                    hour = start_dt.hour
                    minute = start_dt.minute
                    start_interval = (minute // (60 // interval_count))

                    # Fill in cells for "start" and "busy" states
                    for i in range(start_interval, interval_count):
                        if hour > table_end:
                            break
                        if i == start_interval:
                            table[hour][i] = format_title(title, max_col_width, links)
                        else:
                            table[hour][i] = "-" * (max_col_width - 2)

                    # Continue marking cells as "busy" in subsequent hours if task spans multiple hours
                    while hour < end_dt.hour:
                        hour += 1
                        for j in range(interval_count):
                            if hour > table_end or (hour == end_dt.hour and j >= start_interval):
                                break
                            table[hour][j] = "-" * (max_col_width - 2)

    # Generate table header and rows with consistent width for alignment
    header_cells = [f":{i * (60 // interval_count):02}" for i in range(interval_count)]
    table_header = "|     | " + " | ".join(f"{cell:<{cell_width}}" for cell in header_cells) + " |"
    separator = "|" + "+".join(["-" * cell_width] * (interval_count + 1)) + "|"

    # Build rows for tasks
    rows = [f"|  <{table_start} | " + " | ".join(f"{format_title(task, cell_width):<{cell_width}}" for task in early_tasks) + " |"]

    for hour in range(table_start, table_end + 1):
        hour_row = f"|  {hour:2d} | " + " | ".join(f"{cell:<{cell_width}}" for cell in table[hour]) + " |"
        rows.append(hour_row)

    rows.append(f"|  >{table_end} | " + " | ".join(f"{format_title(task, cell_width):<{cell_width}}" for task in late_tasks) + " |")

    # Output the final table
    output = "\n".join([table_header, separator] + rows)
    if output_file:
        with open(output_file, 'w') as f:
            f.write(output)
    else:
        print(output)

# Command-line argument parser
def main():
    parser = argparse.ArgumentParser(description="Generate a timeblock table from Org mode file tasks.")
    parser.add_argument("org_file", help="Path to the Org mode file.")
    parser.add_argument("--detail", "-d", choices=["hour", "half", "quarter"], default="half",
                        help="Table detail level (default: half).")
    parser.add_argument("--max-col-width", "-w", type=int, default=15,
                        help="Maximum width of each column in characters (default: 15).")
    parser.add_argument("--table-start", "-s", type=int, default=7,
                        help="Start hour of the table in 24-hour format (default: 7).")
    parser.add_argument("--table-end", "-e", type=int, default=21,
                        help="End hour of the table in 24-hour format (default: 21).")
    parser.add_argument("--links", action="store_true", help="Add links to task titles.")
    parser.add_argument("--output", "-o", help="Filepath to save the output.")
    
    args = parser.parse_args()
    timeblock(args.org_file, args.detail, args.max_col_width, args.table_start, args.table_end, args.links, args.output)

if __name__ == "__main__":
    main()

