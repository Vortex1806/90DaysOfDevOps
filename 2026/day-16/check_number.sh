#!/bin/bash

read -p "Enter a number: " NUM

if [ $NUM -gt 0 ];
then
        echo "This is a positive number"
elif [ $NUM -lt 0 ];
then
        echo "This is a negative number"
else
        echo "It is 0"
fi