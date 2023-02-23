#!/bin/bash

cd $ODOO_PATH
echo $PWD
git checkout $ODOO_VERS
git pull
