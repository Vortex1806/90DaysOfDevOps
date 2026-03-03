#!/bin/bash

read -p "Enter file name to be checked: " FILE
if [ -f  $FILE ]; then
        echo "This file exists"
else
        echo "This file does not exist"
fi
