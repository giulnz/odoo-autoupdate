#!/bin/bash

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
