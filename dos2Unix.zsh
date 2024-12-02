#!/bin/bash

# Check if the directory argument is provided
if [ -z "$1" ]; then
  echo "Usage: $(basename "$0") <directory>"
  exit 1
fi

# Assign the directory to a variable
DIRECTORY="$1"

# Verify that the provided argument is a directory
if [ ! -d "$DIRECTORY" ]; then
  echo "Error: The provided argument is not a directory."
  exit 1
fi

# Find all files in the directory and convert them
find "$DIRECTORY" -type f -print0 | while IFS= read -r -d '' FILE; do
  # Convert the file from DOS to Unix format
  dos2unix "$FILE"
done

echo "Conversion completed successfully."
