#!/bin/bash

dir=$(dirname $0)
cd $dir

# Import the configuration file
. autoupdate.conf

cd "$VENV/.."

formatted_folders="$formatted_folders,$ODOO_PATH"

if [ -n "$VENV" ]; then
  # Get into python virtualization
  source "$VENV/bin/activate"
fi 

if [ -n "$REQUIREMENTS" ]; then
  echo REQUIREMENTS non vuoto $REQUIREMENTS
  for dir in $(echo "$REQUIREMENTS" | tr ',' '\n'); do
    if [ -d "$dir" ]; then
      if [ -f "$dir/requirements.txt" ]; then
        echo -e "Installing packages from $dir/requirements.txt\n"
        pip3 install -r "$dir/requirements.txt"
        echo -e "\n"
      else
        echo -e "Skipping $dir (no requirements.txt found)\n"
      fi
    else
      echo -e "Skipping $dir (not a directory)\n"
    fi
  done
else
  echo REQUIREMENTS vuoto $REQUIREMENTS
  for dir in $(echo "$formatted_folders" | tr ',' '\n'); do
    if [ -d "$dir" ]; then
      if [ -f "$dir/requirements.txt" ]; then
        echo -e "Installing packages from $dir/requirements.txt\n"
        pip3 install -r "$dir/requirements.txt"
        echo -e "\n"
      else
        echo -e "Skipping $dir (no requirements.txt found)\n"
      fi
    else
      echo -e "Skipping $dir (not a directory)\n"
    fi
  done
fi

$ODOO_PATH/odoo-bin -c "$ODOO_CONF" -d "$DB_NAME" -u all --stop-after-init

if [ -n "$VENV" ]; then
  deactivate
fi
