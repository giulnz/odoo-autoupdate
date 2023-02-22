#!/bin/bash

# Fermo il servizio odoo
sudo /bin/systemctl stop odoo.service

# Aggiorno OCA (UTENTE ODOO)
sudo -u odoo source /opt/odoo/cron/updateOCA.sh

# Aggiorno lista addons su conf odoo
source /opt/odoo/cron/upd_conf_add_folder.sh

# Aggiorno Odoo (UTENTE ODOO)
sudo -u odoo source /opt/odoo/cron/update14.sh

# Aggiorno DB (UTENTE ODOO)
sudo -u odoo source /opt/odoo/cron/updateDB.sh

# Riavvio il servizio odoo
sudo /bin/systemctl start odoo.service
