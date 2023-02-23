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

current_dir=$(pwd)

# Create a log file and open it for writing
log_file="$LOGFILE$(date +"%Y-%m-%d_%H-%M-%S").log"
exec > >(tee -i $log_file)

# Import the configuration file
. autoupdate.conf

# Stop the odoo service (as super user)
sudo /bin/systemctl stop $ODOO_SERVICE.service

# Update OCA (AS ODOO USER)
su - $ODOO_USER -s /bin/bash $current_dir/updateOCA.sh

# Update CUSTOM_FOLDER (AS ODOO USER)
su - $ODOO_USER -s /bin/bash $current_dir/update_custom_addons.sh

# Update ODOO (AS ODOO USER)
su - $ODOO_USER -s /bin/bash $current_dir/update_odoo.sh

# Aggiorno lista addons su conf odoo (as super user )
sudo $current_dir/upd_conf_add_folder.sh

# Update DB (AS ODOO USER)
su - $ODOO_USER -s /bin/bash $current_dir/updateDB.sh

# Riavvio il servizio odoo (as super user )
sudo /bin/systemctl start $ODOO_SERVICE.service
