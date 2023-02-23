#!/bin/bash

if [ -n "$VENV" ]; then
  cd "$VENV/.."
  # Get into python virtualization
  source "$VENV/bin/activate"
fi 

if [ -n "$REQUIREMENTS" ]; then
  for dir in $(echo "$formatted_folders" | tr ',' '\n'); do
    if [ -d "$dir" ]; then
      if [ -f "$dir/requirements.txt" ]; then
        pip3 install -r "$dir/requirements.txt"
      fi
    fi
  done
else
  for dir in $(echo "$REQUIREMENTS" | tr ',' '\n'); do
    if [ -d "$dir" ]; then
      if [ -f "$dir/requirements.txt" ]; then
        pip3 install -r "$dir/requirements.txt"
      fi
    fi
  done
fi

$ODOO_PATH/odoo-bin -c "$ODOO_CONF" -d "$DB_NAME" -u all --stop-after-init

if [ -n "$VENV" ]; then
  deactivate
fi
