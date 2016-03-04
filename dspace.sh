#!/usr/bin/env bash

set -e
#All of this is executed as the DSpace user

cd /home/dspace

### Tomcat
wget  -O apache-tomcat-7.0.68.tar.gz "http://ftp.download-by.net/apache/tomcat/tomcat-7/v7.0.68/bin/apache-tomcat-7.0.68.tar.gz"
tar -xzf apache-tomcat-7.0.68.tar.gz
tomcatDir=/home/dspace/apache-tomcat-7.0.68/


### Dspace
wget  -O dspace-5.2-src-release.tar.gz "http://downloads.sourceforge.net/project/dspace/DSpace%20Stable/5.2/dspace-5.2-src-release.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fdspace%2F&ts=1455631293&use_mirror=freefr"
tar -xzf dspace-5.2-src-release.tar.gz
dspaceDir="/home/dspace/install"
sourceDir="/home/dspace/dspace-5.2-src-release"
mkdir -p $dspaceDir

cd $sourceDir

#Edit the build properties
sed -i "s|\(dspace.install.dir=\).*|\1$dspaceDir|g" build.properties
sed -i "s|\(dspace.hostname=\).*|\1$(hostname -f)|g" build.properties
sed -i "s|\(dspace.baseUrl=\).*|\1http://$(hostname -f):8080|g" build.properties
sed -i "s|\(default.language=\).*|\1da_DK|g" build.properties
sed -i "s|\(db.password=\).*|\1dspacePass|g" build.properties
sed -i "s|\(mail.server =\).*|\1mobile.statsbiblioteket.dk|g" build.properties
sed -i "s|\(mail.server.username=\).*|\1statbib@gmail.com|g" build.properties
sed -i "s|\(mail.server.password=\).*|\1Statsbiblioteket|g" build.properties


#Build DSpace
mvn package
cd /home/dspace/dspace-5.2-src-release/dspace/target/dspace-installer
ant fresh_install
cd /home/dspace/install/config
sed -i "s|\(mail.server =\).*|\1mobile.statsbiblioteket.dk|g" dspace.cfg
echo "mail.extraproperties = mail.smtp.socketFactory.port=465, \ mail.smtp.socketFactory.class=, \ mail.smtp.socketFactory.fallback=false" >> dspace.cfg


#Install the dspace webservices
cp -r $dspaceDir/webapps/* $tomcatDir/webapps

#Start tomcat
$tomcatDir/bin/startup.sh

#test and create user
$dspaceDir/bin/dspace database test
$dspaceDir/bin/dspace create-administrator -e kaah@statsbiblioteket.dk -f Knud -l Hansen -c en -p hidden
$dspaceDir/bin/dspace create-administrator -e khg@statsbiblioteket.dk -f Katrine -l Gasser -c en -p hidden
$dspaceDir/bin/dspace create-administrator -e baj@statsbiblioteket.dk -f Bolette -l Jurik -c en -p hidden

echo "Now go to http://localhost:1234/xmlui/ and log in as kaah@statsbiblioteket.dk with pass 'hidden'"
