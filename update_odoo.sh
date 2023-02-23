#!/bin/bash

cd /opt/odoo/14.0
git checkout 14.0
git pull | tee /opt/odoo/log/log_update14_$(date +"%Y-%m-%d_%H-%M-%S").txt
