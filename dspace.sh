#!/usr/bin/env bash

#All of this is executed as the DSpace user

cd /home/dspace

### Tomcat
wget -q -O apache-tomcat-7.0.67.tar.gz "http://ftp.download-by.net/apache/tomcat/tomcat-7/v7.0.67/bin/apache-tomcat-7.0.67.tar.gz"
tar -xzf apache-tomcat-7.0.67.tar.gz
tomcatDir=/home/dspace/apache-tomcat-7.0.67/


### Dspace
wget -q -O dspace-5.2-src-release.tar.gz "http://downloads.sourceforge.net/project/dspace/DSpace%20Stable/5.2/dspace-5.2-src-release.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fdspace%2F&ts=1455631293&use_mirror=freefr"
tar -xzf dspace-5.2-src-release.tar.gz
dspaceDir="/home/dspace/install"
mkdir -p $dspaceDir

cd dspace-5.2-src-release

#Edit the build properties
sed -i "s|\(dspace.install.dir=\).*|\1$dspaceDir|g" build.properties
sed -i "s|\(dspace.hostname=\).*|\1$(hostname -f)|g" build.properties
sed -i "s|\(dspace.baseUrl=\).*|\1http://$(hostname -f):8080|g" build.properties
sed -i "s|\(default.language=\).*|\1da_DK|g" build.properties
sed -i "s|\(db.password=\).*|\1dspacePass|g" build.properties
#TODO jeg har ikke sat mail settings up endnu, jeg ved ikke lige hvad de skal være


#Build DSpace
mvn package
cd dspace/target/dspace-installer
ant fresh_install

#Install the dspace webservices
cp -r $dspaceDir/webapps/* $tomcatDir/webapps

#Start tomcat
$tomcatDir/bin/startup.sh

#test and create user
$dspaceDir/bin/dspace database test
$dspaceDir/bin/dspace create-administrator -e kaah@statsbiblioteket.dk -f Knud -l Hansen -c en -p hidden

echo "No go to http://localhost:8080/xmlui/ and log in as kaah@statsbiblioteket.dk with pass 'hidden'"