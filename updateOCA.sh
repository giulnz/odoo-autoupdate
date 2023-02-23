#!/bin/bash

# Verify that the input variables are set
if [[ -z "$OCA_FOLDER" || -z "$ODOO_VERS" || -z "$ODOO_CONF" ]]; then
  echo "Error: one or more input variables not set" >&2
  exit 1
fi

cd $OCA_FOLDER
cd ..
gh repo list OCA --limit 500 | while read -r repo _; do
  if $EXCLUDE_REPO; then
    echo "Skip $repo"
    continue
  fi
  echo "$repo"
  gh repo clone "$repo" "$repo" -- --branch $ODOO_VERS --depth=1 || (
    cd "$repo"
    git checkout || true
    git pull
  )
done
