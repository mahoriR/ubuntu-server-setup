#!/bin/bash

function installDocker(){
    sudo apt update
    sudo apt  --assume-yes install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    sudo apt update
    #install Docker
    sudo apt --assume-yes install docker-ce
    #to avoid typing sudo whenever you run the docker command, add your username to the docker group
    echo "Adding you to docker group"
    sudo usermod -aG docker ${USER}

    #To apply the new group membership, log out of the server and back in, or type the following:
    echo "Done, run docker --version to verify"
    echo "Logging back in.. Run dockerCompose script after this if required"

}



function installDockerCompose(){
    sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    #Then we’ll verify that the installation was successful by checking the version:
    docker-compose --version
}