#!/usr/bin/env bash
set -o pipefail

# Variables
NOTE_NAME="Refile"  # Default note name
FOLDER_NAME="Notes" # Default folder
OUTPUT=""

# Help message function
usage() {
    cat <<EOF
'saveNote' usage:
  General:
    -h, --help, -?            Print this help message.

  Options:
    --note-name=NOTE_NAME     Specify the name of the note to fetch (default: "Refile").
    --folder-name=FOLDER_NAME Specify the folder containing the note (default: "Notes").
    --output=FILE_NAME        Specify the output file name (default: dynamic timestamp-based name).

  Example:
    ./saveNote.sh --note-name="Refile" --folder-name="Notes"
EOF
}

# Parse options
if [[ $1 == '-h' || $1 == '--help' || $1 == '-?' ]]; then
    usage
    exit 0
fi

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --note-name=*) NOTE_NAME="${1#*=}" ;;
        --folder-name=*) FOLDER_NAME="${1#*=}" ;;
        --output=*) OUTPUT="${1#*=}" ;; # Optional: Custom output name
        *) echo "Unknown parameter passed: $1"; usage; exit 1 ;;
    esac
    shift
done

# Generate a dynamic timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%a_%H%M")

# Determine the output file name if not provided
if [[ -z "$OUTPUT" ]]; then
    OUTPUT="${TIMESTAMP}_iphone_capture.html"
fi

# Define the Org output file name
ORG_OUTPUT="${OUTPUT%.html}.org"

# Define the capture directory
CAPTURE_DIR=~/auxRoam/capture_mobile

# Ensure the capture directory exists
if [[ ! -d "$CAPTURE_DIR" ]]; then
    echo "Error: Capture directory $CAPTURE_DIR does not exist."
    exit 1
fi

# Fetch the note content
NOTE_CONTENT=$(osascript fetchNote.scpt "$NOTE_NAME" "$FOLDER_NAME")
if [[ -z "$NOTE_CONTENT" ]]; then
    echo "Error: Failed to fetch note content from Notes."
    exit 1
fi

# Save the note content to the output file
echo "$NOTE_CONTENT" > "$OUTPUT"
if [[ ! -f "$OUTPUT" ]]; then
    echo "Error: Failed to save note content to $OUTPUT."
    exit 1
fi
echo "Saved note content to $OUTPUT"

# Convert HTML to Org-mode format using Pandoc
pandoc -o "$ORG_OUTPUT" "$OUTPUT"
if [[ ! -f "$ORG_OUTPUT" ]]; then
    echo "Error: Failed to convert HTML to Org-mode format."
    rm "$OUTPUT" # Clean up the HTML file if conversion fails
    exit 1
fi

# Remove the HTML file after conversion
rm "$OUTPUT"
if [[ -f "$OUTPUT" ]]; then
    echo "Error: Failed to remove intermediate HTML file."
    exit 1
fi
echo "Removed intermediate HTML file: $OUTPUT"

# Clean the Org file by removing Zero-Width Space characters
sed -i.bak $'s/\xE2\x80\x8B//g' "$ORG_OUTPUT" && rm "${ORG_OUTPUT}.bak"

# Verify that the zero-width space character was removed
if grep -q $'\xE2\x80\x8B' "$ORG_OUTPUT"; then
    echo "Error: Failed to remove Zero-Width Space characters from $ORG_OUTPUT."
    exit 1
fi

echo "Cleaned Zero-Width Space characters from $ORG_OUTPUT"

# Move the Org file to the capture directory
mv "$ORG_OUTPUT" "$CAPTURE_DIR/"
if [[ ! -f "$CAPTURE_DIR/$ORG_OUTPUT" ]]; then
    echo "Error: Failed to move Org file to $CAPTURE_DIR."
    exit 1
fi
echo "Moved Org file to $CAPTURE_DIR"
