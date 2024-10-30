#!/bin/bash

# Script to update system and Security Onion, and handle reboot

# Variables
LOG_FILE="/var/log/update_script_$(date +%F).log"

# Function to check for required commands
function check_command {
    command -v "$1" >/dev/null 2>&1 || { echo >&2 "$1 is required but not installed. Aborting."; exit 1; }
}

# Create log file and redirect output
exec > >(tee -i "$LOG_FILE")
exec 2>&1

# Check for required commands
check_command "yum"
check_command "systemctl"

# Update package lists and upgrade packages
echo "[$(date)] Updating package lists..."
sudo yum check-update
echo "[$(date)] Upgrading packages..."
sudo yum update -y
echo "[$(date)] Cleaning up unnecessary packages..."
sudo yum autoremove -y

# Update Security Onion components
echo "[$(date)] Updating Security Onion components..."
yes | sudo soap || { echo "Security Onion update failed. Aborting."; exit 1; }

# Check if a reboot is required
if [ -f /var/run/reboot-required ]; then
    echo "[$(date)] Reboot required."
fi

# Reboot the system
echo "[$(date)] Rebooting now..."
sudo reboot
