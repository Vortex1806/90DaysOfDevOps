#!/bin/bash

if [ "$EUID" -ne 0 ]
then
        echo "Please run as root"
        exit 1
fi

apt-get update -y

for package in nginx curl wget
do
        if dpkg -s $package &>/dev/null
        then
                echo "Package $package already installed"
        else
                apt-get install $package -y
                echo "$package installeddd......."
        fi
done