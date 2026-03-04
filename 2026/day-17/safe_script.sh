#!/bin/bash

set -e

mkdir /tmp/devops-test || echo "Directory already exists"

cd /tmp/devops-test || { echo "Directory not navigable" ; exit 1 ; }

touch hello.txt || { echo "Could not create the file"; exit 1; }