#!/bin/bash
################################################################################
# Script for update odoo and all the addons contained in OCA.
# Author: Grando Giulio
#-------------------------------------------------------------------------------
# git clone https://github.com/ser-tec/odoo-autoupdate.git
# makes the file executable:
# sudo chmod +x odoo_autoupdate.sh
# Execute the script to update Odoo:
# ./odoo_autoupdate.sh
################################################################################

dir=$(dirname $0)
cd $dir

# Import the configuration file
. autoupdate.conf

# Create a log file and open it for writing
log_file="$LOGFILE$(date +"%Y-%m-%d_%H-%M-%S").log"
exec > >(tee -i $log_file)

var_list=("LOGFILE" "ODOO_PATH" "ODOO_SERVICE" "ODOO_USER" "ODOO_CONF" "OCA_FOLDER" "CUSTOM_FOLDERS" "FIX_FOLDERS" "ODOO_VERS" "DB_NAME")

    for var in "${var_list[@]}"
    do
        if [ -z "${!var}" ]
        then
            echo "La variabile $var non è stata impostata. Si prega di impostare la variabile prima di eseguire lo script."
            exit 1
        fi
    done

# test variabili
echo test variabili
su - $ODOO_USER -s /bin/bash $dir/test_var.sh


# Stop the odoo service (as super user)
sudo /bin/systemctl stop $ODOO_SERVICE.service

# Update OCA (AS ODOO USER)
echo Update OCA
su - $ODOO_USER -s /bin/bash $dir/updateOCA.sh

# Update CUSTOM_FOLDER (AS ODOO USER)
echo Update CUSTOM_FOLDER
su - $ODOO_USER -s /bin/bash $dir/update_custom_addons.sh

# Update ODOO (AS ODOO USER)
echo Update ODOO
su - $ODOO_USER -s /bin/bash $dir/update_odoo.sh

# Update addons list on conf odoo (as super user )
echo Update addons list
sudo $dir/upd_conf_add_folder.sh

# Update DB (AS ODOO USER)
echo Update DB
su - $ODOO_USER -s /bin/bash $dir/updateDB.sh

# Riavvio il servizio odoo (as super user )
sudo /bin/systemctl start $ODOO_SERVICE.service
