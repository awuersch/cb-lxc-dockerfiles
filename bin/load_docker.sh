#!/bin/bash

set -euf -o pipefail

function get_docker { #
    sudo apt-get install \
            gnupg2 \
            software-properties-common -y

    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable"

    sudo apt-get update
    sudo apt-get install docker-ce -y
    sudo usermod -aG docker $(whoami)
}

get_docker
