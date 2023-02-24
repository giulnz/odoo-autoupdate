#!/bin/bash
################################################################################
# Script for update odoo and all the addons contained in OCA.
# Author: Grando Giulio
#-------------------------------------------------------------------------------
# git clone https://github.com/ser-tec/odoo-autoupdate.git
# makes the file executable:
# sudo chmod +x autoupdate.sh
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

# Stop the odoo service (as super user)
if sudo /bin/systemctl stop $ODOO_SERVICE.service; then
  echo "Odoo service stopped successfully"
else
  echo "Failed to stop Odoo service"
fi

# Update OCA (AS ODOO USER)
echo 
echo Update OCA
echo 
su - $ODOO_USER -s /bin/bash $dir/updateOCA.sh

# Update CUSTOM_FOLDER (AS ODOO USER)
echo 
echo Update CUSTOM_FOLDER
echo 
su - $ODOO_USER -s /bin/bash $dir/update_custom_addons.sh

# Update ODOO (AS ODOO USER)
echo 
echo Update ODOO
echo 
su - $ODOO_USER -s /bin/bash $dir/update_odoo.sh

# Update addons list on conf odoo (as super user )
echo 
echo Update addons list
echo 
sudo $dir/upd_conf_add_folder.sh

# Update DB (AS ODOO USER)
echo 
echo Update DB
echo 
su - $ODOO_USER -s /bin/bash $dir/updateDB.sh

# Riavvio il servizio odoo (as super user )
if sudo /bin/systemctl start $ODOO_SERVICE.service; then
  echo "Odoo service started successfully"
else
  echo "Failed to start Odoo service"
fi
