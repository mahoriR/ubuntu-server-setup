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
    source "${current_dir}/setupDockerLibrary.sh"
}

current_dir=$(getCurrentDir)

includeDependencies

function main() {

    disableSudoPassword "${USER}"

    installDockerCompose

    cleanup

    echo "Done, run docker-compose --version to verify"
}


function cleanup() {
    if [[ -f "/etc/sudoers.bak" ]]; then
        revertSudoers
    fi
}


main