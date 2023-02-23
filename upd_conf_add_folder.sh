#!/bin/bash

# Setting the field separator
IFS=','

# Folder list
variable_folders=$(ls -d $VAR_FOLDERS/*/ 2>/dev/null)
fix_folders="${FIX_FOLDERS[*]}"

# Error checking
if [ $? -ne 0 ]; then
  echo "Error generating folder list" >&2
  exit 1
fi

# Format the folder list
formatted_folders=$(echo "$fix_folders,$variable_folders" | tr '\n' ',')

# Remove the last comma
formatted_folders=${formatted_folders%,}

# Update the file specified in output_file
sed -i "s|addons_path = .*|addons_path = $formatted_folders|" "$ODOO_CONF"

# Error checking
if [ $? -ne 0 ]; then
  echo "Error writing file" >&2
  exit 1
fi

echo "The folder list was successfully written to the file $ODOO_CONF"
