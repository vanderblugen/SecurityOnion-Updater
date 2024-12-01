#!/bin/bash

# Function to log messages using syslog (via logger)
log_message() {
    logger -t "securityonion-update" "$1"
}

# Log start of the process
log_message "Starting Security Onion update process at $(date)"

# Update system packages using yum
log_message "Updating system packages using yum..."
sudo yum -y update
if [ $? -eq 0 ]; then
    log_message "System packages updated successfully."
else
    log_message "Error updating system packages."
    exit 1
fi

# Upgrade system packages
log_message "Upgrading system packages using yum..."
sudo yum -y upgrade
if [ $? -eq 0 ]; then
    log_message "System packages upgraded successfully."
else
    log_message "Error upgrading system packages."
    exit 1
fi

# Check the status of Security Onion components
log_message "Checking the status of Security Onion components..."
so-status

# Update Suricata rules
log_message "Updating Suricata rules..."
so-suricata-reload-rules
if [ $? -eq 0 ]; then
    log_message "Suricata rules updated successfully."
else
    log_message "Error updating Suricata rules."
    exit 1
fi

# Update Elastic Fleet URLs
log_message "Updating Elastic Fleet URLs..."
so-elastic-fleet-urls-update
if [ $? -eq 0 ]; then
    log_message "Elastic Fleet URLs updated successfully."
else
    log_message "Error updating Elastic Fleet URLs."
    exit 1
fi

# Upgrade Elastic Fleet packages
log_message "Upgrading Elastic Fleet packages..."
so-elastic-fleet-package-upgrade
if [ $? -eq 0 ]; then
    log_message "Elastic Fleet packages upgraded successfully."
else
    log_message "Error upgrading Elastic Fleet packages."
    exit 1
fi

# Restart Suricata
log_message "Restarting Suricata..."
so-suricata-restart
if [ $? -eq 0 ]; then
    log_message "Suricata restarted successfully."
else
    log_message "Error restarting Suricata."
    exit 1
fi

# Restart Elasticsearch with --force
log_message "Restarting Elasticsearch with --force..."
so-elasticsearch-restart --force
if [ $? -eq 0 ]; then
    log_message "Elasticsearch restarted successfully with --force."
else
    log_message "Error restarting Elasticsearch with --force."
    exit 1
fi

# Restart Kibana
log_message "Restarting Kibana..."
so-kibana-restart
if [ $? -eq 0 ]; then
    log_message "Kibana restarted successfully."
else
    log_message "Error restarting Kibana."
    exit 1
fi

# Check the status of the services again after updates
log_message "Checking the status of Security Onion components after updates..."
so-status

# Log the completion of the process
log_message "Security Onion update process completed at $(date)."

# Reboot the system to apply all changes
log_message "Rebooting the system to apply all changes."
# sudo reboot

# End of script
