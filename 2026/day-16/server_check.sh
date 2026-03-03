#!/bin/bash

SERVICE="nginx"

read -p "Do you want to check the status of nginx(y/n): " CH

if [ $CH == "y" ]; then
        echo "checking status"
        if systemctl is-active --quiet $SERVICE; then
                echo "$SERVICE is active"
        else
                echo "$SERVICE is down"
        fi
else
        echo "Skipping"
fi