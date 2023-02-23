# Odoo-autoupdate

This collection of scripts allows you to update odoo and all the addons contained in OCA.

```grouper.sh``` -> it runs the other scripts in the right order. It Stop the odoo service during the update process and restart after finished<br/>
```updateOCA.sh``` -> it download the new modules contained in the OCA repository and update the existing ones skipping those specified in the exclude_folder parameter.<br/>
```upd_conf_add_folder.sh``` -> it writes the list of addons in the odoo configuration file <br/>
```update_odoo.sh``` -> it update odoo<br/>
```updateDB.sh``` -> it install dependencies and update the database<br/>

## Prerequisites 
* ubuntu
* odoo installed from source

## Settings

Define your own parameters in autoupdate.conf
```
$ nano autoupdate.conf
```

## Scheduling
* Edit cron:
```
$ sudo crontab -e
```
* Add the following entries. Save and exit.<br/> 
Help for scheduling https://crontab.guru/
```
00 0 * * * /opt/odoo/odoo-autoupdate/grouper.sh
```
