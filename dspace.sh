#!/usr/bin/env bash

set -e
#All of this is executed as the DSpace user

cd /home/dspace

### Tomcat
wget  -O apache-tomcat-7.0.68.tar.gz "http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.68/bin/apache-tomcat-7.0.68.tar.gz"
tar -xzf apache-tomcat-7.0.68.tar.gz
tomcatDir=/home/dspace/apache-tomcat-7.0.68/

### Dspace
wget  -O dspace-5.5-release.tar.gz "https://github.com/DSpace/DSpace/releases/download/dspace-5.5/dspace-5.5-release.tar.gz"
tar -xzf dspace-5.5-release.tar.gz
dspaceDir="/home/dspace/install"
sourceDir="/home/dspace/dspace-5.5-release"
mkdir -p $dspaceDir

cd $sourceDir

#Edit the build properties
sed -i "s|\(dspace.install.dir=\).*|\1$dspaceDir|g" build.properties


#Build DSpace
mvn package
cd /home/dspace/dspace-5.5-release/dspace/target/dspace-installer
ant fresh_install
pushd /home/dspace/install/config
sed -i "s|\(mail.server =\).*|\1mobile.statsbiblioteket.dk|g" dspace.cfg
sed -i "s|\(dspace.hostname =\).*|\1pc621.sb.statsbiblioteket.dk|g" dspace.cfg
sed -i "s|\(dspace.baseUrl =\).*|\1pc621.sb.statsbiblioteket.dk:1234|g" dspace.cfg
sed -i "s|\(dspace.url =\).*|\1pc621.sb.statsbiblioteket.dk:9841/xmlui|g" dspace.cfg
echo "mail.extraproperties = mail.smtp.socketFactory.port=465, \ mail.smtp.socketFactory.class=, \ mail.smtp.socketFactory.fallback=false" >> dspace.cfg
popd


#Install the dspace webservices
cp -r $dspaceDir/webapps/* $tomcatDir/webapps

#Start tomcat
$tomcatDir/bin/startup.sh

#test and create user
$dspaceDir/bin/dspace database test
$dspaceDir/bin/dspace create-administrator -e statbib@gmail.com -f Stats -l biblioteket -c en -p hidden

echo "Now go to http://localhost:9841/xmlui/ and log in as statbib@gmail.com with pass 'hidden'"
