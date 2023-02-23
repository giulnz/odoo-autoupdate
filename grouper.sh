#!/bin/bash

# Importa il file di configurazione
. autoupdate.conf

# Fermo il servizio odoo
sudo /bin/systemctl stop $ODOO_SERVICE.service

# Aggiorno OCA (UTENTE ODOO)
su - $ODOO_USER -s /bin/bash $ODOO_PATH/odoo-autoupdate/updateOCA.sh

# Aggiorno lista addons su conf odoo
sudo $ODOO_PATH/odoo-autoupdate/upd_conf_add_folder.sh

# Aggiorno Odoo (UTENTE ODOO)
su - $ODOO_USER -s /bin/bash $ODOO_PATH/odoo-autoupdate/update_odoo.sh

# Aggiorno DB (UTENTE ODOO)
su - $ODOO_USER -s /bin/bash $ODOO_PATH/odoo-autoupdate/updateDB.sh

# Riavvio il servizio odoo
sudo /bin/systemctl start $ODOO_SERVICE.service
