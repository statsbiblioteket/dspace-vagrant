#!/usr/bin/env bash

#These are the things that need root access to do

### Java
sudo apt-get update
sudo apt-get -y install openjdk-7-jdk maven 

### Postgres
sudo locale-gen da_DK.UTF-8 #Something wrong with ubuntu, this fixes it
sudo apt-get -y install postgresql
sudo service postgresql start #It might have been started already
echo "CREATE ROLE dspace WITH LOGIN PASSWORD 'dspacePass'; " | sudo -u postgres psql #create the dspace Postgres user
sudo -u postgres createdb  --owner=dspace --encoding=UNICODE dspace #Create the dspace database

#Unix
sudo useradd -m dspace
sudo -u dspace bash /vagrant/dspace.sh

