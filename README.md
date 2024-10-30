# SecurityOnion-Updater
Regular Updating Script for Security Onion

This script will update your SecurityOnion install monthly and reboot.

````bash
sudo nano /usr/local/bin/security_onion_maintenance.sh
````
Paste the contents of the `security_onion_maintenance.sh` file for this repo and press `Ctrl+X` to save and exit.

````bash
sudo chmod +x /usr/local/bin/security_onion_maintenance.sh
sudo ln -s /usr/local/bin/security_onion_maintenance /etc/cron.monthly/security_onion_maintenance.sh
````
