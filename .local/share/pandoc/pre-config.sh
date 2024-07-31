#!/bin/bash
# - [2024-07-30 Tue 17:30]
# This script creates dynamically a config file for
# pandoc. This is because pandoc can not read system
# variables from a config file.

# Default to 80 if the environment variable is not set
LINE_LENGTH=${CUSTOM_CLI_LINE_LENGTH:-80}

# Create the Pandoc configuration file dynamically
cat << EOF > cli.conf
wrap: auto
columns: $LINE_LENGTH
EOF


