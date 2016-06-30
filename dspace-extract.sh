#!/usr/bin/env bash

set -e
set -x
#All of this is executed as the DSpace user
SCRIPT_PATH=$(dirname $(readlink -f $0))

killall -q java || echo "no running javas found :)"

source $SCRIPT_PATH/config
mkdir -p ${DSPACE_INSTALL_DIR}
mkdir -p ${DSPACE_SOURCE_DIR}
mkdir -p ${TOMCAT_DIR}

TEMPDIR=$(mktemp -d)
cd $TEMPDIR

### Tomcat
wget  -O apache-tomcat.tar.gz ${TOMCAT_DOWNLOAD_URL}
tar -xzf apache-tomcat.tar.gz --strip-components 1 -C $TOMCAT_DIR
rm -rf $TOMCAT_DIR/webapps/* #Removing default webservices


### Run DSpace installer
tar -xzf /vagrant/dspace-5.5-SB-0.1-SNAPSHOT-installer.tar.gz -C ${DSPACE_SOURCE_DIR}
pushd $DSPACE_SOURCE_DIR
    sed -i "s|\(dspace.dir = \).*|\1$DSPACE_INSTALL_DIR|g" config/dspace.cfg
    sed -i "s|\(dspace.hostname = \).*|\1dspace-devel|g" config/dspace.cfg
    sed -i "s|\(dspace.baseUrl = \).*|\1http://dspace-devel:9841/|g" config/dspace.cfg
    sed -i "s|\(dspace.url = \).*|\1http://dspace-devel:9841/xmlui|g" config/dspace.cfg
    sed -i "s|\(dspace.name = \).*|\1Statsbiblioteket|g" config/dspace.cfg
    sed -i "s|\(default.language = \).*|\1da_DK|g" config/dspace.cfg
    sed -i "s|\(db.password = \).*|\1dspacePass|g" config/dspace.cfg
    echo "mail.extraproperties = mail.smtp.socketFactory.port=465, \ mail.smtp.socketFactory.class=, \ mail.smtp.socketFactory.fallback=false" >> config/dspace.cfg

    #Ant reads config from
    #  config/dspace.cfg
    #  ${user.home}/.dspace.properties

    ant -Dwars=true fresh_install
popd

#Install the dspace webservices
mkdir -p $TOMCAT_DIR/webapps/
cp  $DSPACE_INSTALL_DIR/webapps/*.war $TOMCAT_DIR/webapps

#Start tomcat
$TOMCAT_DIR/bin/startup.sh

#test and create user
$DSPACE_INSTALL_DIR/bin/dspace database test
$DSPACE_INSTALL_DIR/bin/dspace create-administrator -e statbib@gmail.com -f Stats -l biblioteket -c en -p hidden



#Dump database
pg_dump >> /home/dspace/dump.sql

#Package dspace
rm -f /vagrant/installed.tar.gz
tar -cvzf /vagrant/installed.tar.gz \
    --exclude $DSPACE_INSTALL_DIR/webapps \
    $DSPACE_INSTALL_DIR
tar -rvzf /vagrant/installed.tar.gz $TOMCAT_DIR/webapps/*.war