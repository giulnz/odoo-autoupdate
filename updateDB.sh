#!/bin/bash

cd /opt/odoo

# Crea un file di log e lo apre per la scrittura
log_file="log/log_updateDB$(date +"%Y-%m-%d_%H-%M-%S").txt"
exec > >(tee -i $log_file)

# Entra nella virtualizzazione python
source venv/bin/activate

# Verifica se l'esecuzione del comando precedente ha restituito un errore
if [ $? -eq 0 ]; then
  # Se il comando ha restituito 0 (successo), esegue il comando successivo
  pip3 install -r addons/OCA/l10n-italy/requirements.txt
  pip3 install -r 14.0/requirements.txt
  14.0/odoo-bin -c /etc/odoo/odoo.conf -d database14 -u all --stop-after-init
  deactivate
else
  # Se il comando ha restituito un valore diverso da 0 (errore), visualizza un messaggio di errore
  echo "Errore nell'esecuzione del comando 'source venv/bin/activate'"
fi

