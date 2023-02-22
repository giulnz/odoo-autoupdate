#!/bin/bash

cd /opt/odoo/addons
gh repo list OCA --limit 500 | while read -r repo _; do
  if [ "$repo" == "OCA/OCB" ] || [[ "$repo" =~ ^OCA/l10n.* ]] && [ "$repo" != "OCA/l10n-italy" ]; then
    echo "Salto $repo"
    continue
  fi
  echo "$repo"
  gh repo clone "$repo" "$repo" -- --branch 14.0 --depth=1 || (
    cd "$repo"
    git checkout || true
    git pull
  )
done | tee /opt/odoo/log/log_updateOCA$(date +"%Y-%m-%d_%H-%M-%S").txt
