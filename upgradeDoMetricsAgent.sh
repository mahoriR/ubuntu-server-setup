#!/bin/bash

#https://www.digitalocean.com/docs/monitoring/how-to/upgrade-legacy-agent/
sudo apt-get purge do-agent
curl -sSL https://repos.insights.digitalocean.com/install.sh -o /tmp/install.sh
sudo bash /tmp/install.sh