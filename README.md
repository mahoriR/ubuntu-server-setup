# Bash setup script for Ubuntu servers

This is a setup script to automate the setup and provisioning of Ubuntu servers. It does the following:

* Adds a new user account with sudo access
* Adds a public ssh key for the new user account
* Disables password authentication to the server
* Deny root login to the server
* Setup Uncomplicated Firewall (allows ssh tcp(22) only and rate limit)
* Create Swap file based on machine's installed memory
* Setup the timezone for the server (Default to "Asia/Kolkata")
* Install Network Time Protocol

*Bonus 1:* Additionaly scripts `setupDocker.sh` and `setupDockerCompose.sh` can be run as new user to install docker and docker-compose.

*Bonus 2:* Run `setupCreateDeployer.sh` to add a user `deployer`. This user will not have sudo perm and will be added to docker group. Use this for code deployements

## Installation

SSH into your server and install git if it is not installed:

```bash
sudo apt-get update
sudo apt-get install git
```

Clone this repository into your home directory:

```bash
cd ~
git clone https://github.com/mahoriR/ubuntu-server-setup.git
```

Run the setup script

```bash
cd ubuntu-server-setup
bash setup.sh
```

## Setup prompts

When the setup script is run, you will be prompted to enter the username and password of the new user account.

Following that, you will then be prompted to add a public ssh key (which should be from your local machine) for the new account. To generate an ssh key from your local machine:

```bash
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
```

Finally, you will be prompted to specify a [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for the server. It will be set to 'Asia/Kolkata' if you do not specify a value.

## Install Docker

Run as non-root user

```bash
bash setupDocker.sh
```

Follows <https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04>

## Install Docker Compose

Run as non-root user

```bash
bash setupDockerCompose.sh
```

Follows <https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-18-04>

## Upgrade Digital ocean Mertics Agent (Optional). Only Applicable for if setting up a droplet on digital ocean

Run as non-root user

```bash
bash upgradeDoMetricsAgent.sh
```

Follows <https://www.digitalocean.com/docs/monitoring/how-to/upgrade-legacy-agent/>

## Add deployer user for code deployements

Run as non-root user

```bash
bash setupCreateDeployer.sh
```

## Supported versions

This setup script has been tested against Ubuntu 18.04 and Ubuntu 20.04.
