#!/bin/bash

# Default to 80 if the environment variable is not set
LINE_LENGTH=${CUSTOM_CLI_LINE_LENGTH:-80}

# Create the Pandoc configuration file dynamically
cat << EOF > pandoc.conf
wrap: auto
columns: $LINE_LENGTH
EOF


