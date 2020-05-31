#!/bin/bash

set -e

function getCurrentDir() {
    local current_dir="${BASH_SOURCE%/*}"
    if [[ ! -d "${current_dir}" ]]; then current_dir="$PWD"; fi
    echo "${current_dir}"
}

function includeDependencies() {
    # shellcheck source=./setupLibrary.sh
    source "${current_dir}/setupLibrary.sh"
}

current_dir=$(getCurrentDir)
includeDependencies

function main() {
    echo "Creating new user - 'deployer'\n\nThis user is not sudoer, use this for code deployements\n\n"

    promptForPassword

    addNonSudoUserAccount "deployer" "${password}"

    echo "Copying current ssh keys to deployer"
    sudo rsync --archive  --chown=deployer:deployer ~/.ssh /home/deployer

    echo "Adding deployer to group docker"
    sudo usermod -aG docker deployer

    echo "Done! login as deployer and build something awesome!"
}


# Keep prompting for the password and password confirmation
function promptForPassword() {
   PASSWORDS_MATCH=0
   while [ "${PASSWORDS_MATCH}" -eq "0" ]; do
       read -s -rp "Enter new UNIX password:" password
       printf "\n"
       read -s -rp "Retype new UNIX password:" password_confirmation
       printf "\n"

       if [[ "${password}" != "${password_confirmation}" ]]; then
           echo "Passwords do not match! Please try again."
       else
           PASSWORDS_MATCH=1
       fi
   done 
}

main