#!/bin/bash

echo "Running apt update"
apt-get update -y
echo "Installing nginx"
apt-get install nginx -y

# echo "Welcome to the AzurefromScratch project" > index.html
# sudo mv index.html /var/www/html/
