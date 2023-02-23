#!/bin/bash

CUSTOM_FOLDER=("/opt/odoo/14.0/addons" "/opt/odoo/14.0/addons/custom")

# loop through all folders in $CUSTOM_FOLDER
for folder in "${CUSTOM_FOLDER[@]}"; do
    echo "Updating folder: $folder"
    cd "$folder"
    git checkout || true
    git pull

    # loop through all subfolders in $folder
    for subfolder in */; do
        echo "Updating subfolder: $subfolder"
        cd "$subfolder"
        git checkout || true
        git pull
        cd ..
    done
done
