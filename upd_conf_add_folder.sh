#!/bin/bash

# Percorso di destinazione del file
output_file="/etc/odoo/odoo.conf"

# Lista delle cartelle
# puo essere scritto anche così 
variable_folders=$(ls -d /opt/odoo/addons/{OCA,custom}/*/ 2>/dev/null)
fix_folders="/opt/odoo/14.0/addons,/opt/odoo/14.0/addons/custom"

# Controllo degli errori
if [ $? -ne 0 ]; then
  echo "Errore durante la generazione della lista delle cartelle" >&2
  exit 1
fi

# Formatta la lista delle cartelle
formatted_folders=$(echo "$fix_folders,$variable_folders" | tr '\n' ',')

# Rimuove l'ultima virgola
formatted_folders=${formatted_folders%,}

# Aggiorna il file specificato in output_file
sed -i "s|addons_path = .*|addons_path = $formatted_folders|" "$output_file"

# Controllo degli errori
if [ $? -ne 0 ]; then
  echo "Errore durante la scrittura del file" >&2
  exit 1
fi

echo "La lista delle cartelle è stata scritta correttamente nel file $output_file"
