#!/bin/bash

# Script to update system and Security Onion, and handle reboot

# Variables
LOG_FILE="/var/log/update_script_$(date +%F).log"
FLAG_FILE="/var/run/update_flag"

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
yes | sudo soup || { echo "Security Onion update failed. Aborting."; exit 1; }
yes | sudo soup || { echo "Security Onion update failed. Aborting."; exit 1; }
yes | sudo soup || { echo "Security Onion update failed. Aborting."; exit 1; }

# Rebooting is required
echo "[$(date)] Rebooting now..."
touch "$FLAG_FILE"
sudo reboot
