#!/bin/bash

dir=$(dirname $0)
cd $dir

# Import the configuration file
. autoupdate.conf

cd $ODOO_PATH
echo $PWD
git checkout $ODOO_VERS
git pull
