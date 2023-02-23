#!/bin/bash

# Fermo il servizio odoo
sudo /bin/systemctl stop odoo.service

# Aggiorno OCA (UTENTE ODOO)
su - odoo -s /bin/bash /opt/odoo/cron/updateOCA.sh

# Aggiorno lista addons su conf odoo
sudo /opt/odoo/cron/upd_conf_add_folder.sh

# Aggiorno Odoo (UTENTE ODOO)
su - odoo -s /bin/bash /opt/odoo/cron/update_odoo.sh

# Aggiorno DB (UTENTE ODOO)
su - odoo -s /bin/bash /opt/odoo/cron/updateDB.sh

# Riavvio il servizio odoo
sudo /bin/systemctl start odoo.service
