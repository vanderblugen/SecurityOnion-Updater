#!/bin/bash
sudo yum -y update
sudo yum -y upgrade
so-suricata-reload-rules
so-elastic-fleet-urls-update
so-elastic-fleet-package-upgrade
so-suricata-restart --force
so-elasticsearch-restart --force
so-kibana-restart --force
# sudo reboot
