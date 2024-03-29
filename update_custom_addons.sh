#!/bin/bash

dir=$(dirname $0)
cd $dir

# Import the configuration file
. autoupdate.conf

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
