#!/usr/bin/env bash

set -e
#All of this is executed as the DSpace user

tmpDir=/home/dspace/tmp
mkdir -p $tmpDir
cd $tmpDir

### Dspace
wget  -O dspace-5.5-release.tar.gz "https://github.com/DSpace/DSpace/releases/download/dspace-5.5/dspace-5.5-release.tar.gz"
tar -xzf dspace-5.5-release.tar.gz
dspaceDir="/home/dspace"

cd "$tmpDir/dspace-5.5-release"
sed -i "s|\(dspace.install.dir=\).*|\1$dspaceDir|g" build.properties


#Build DSpace
cd dspace
mvn package -Pdspace-lni
cd target/dspace-installer
pushd $dspaceDir
rm  -rf bin config etc lib solr tomcat webapps
popd
ant -Dwars=true update_code update_configs update_webapps

tomcatDir=/home/dspace/tomcat/

mkdir -p $tomcatDir/webapps/
#Install the dspace webservices
cp  $dspaceDir/webapps/*.war $tomcatDir/webapps

cd $dspaceDir
pushd config
sed -i "s|\(dspace.dir = \).*|\1$dspaceDir|g" dspace.cfg
sed -i "s|\(dspace.hostname = \).*|\1dspace-devel|g" dspace.cfg
sed -i "s|\(dspace.baseUrl = \).*|\1http://dspace-devel:9841/|g" dspace.cfg
sed -i "s|\(dspace.url = \).*|\1http://dspace-devel:9841/xmlui|g" dspace.cfg
sed -i "s|\(dspace.name = \).*|\1Statsbiblioteket|g" dspace.cfg
sed -i "s|\(default.language = \).*|\1da_DK|g" dspace.cfg
sed -i "s|\(db.password = \).*|\1Qcqmoj0rsQ5c|g" dspace.cfg
echo "mail.extraproperties = mail.smtp.socketFactory.port=465, \ mail.smtp.socketFactory.class=, \ mail.smtp.socketFactory.fallback=false" >> dspace.cfg
popd
rm installed.tar.gz
tar -cvzf installed.tar.gz --exclude installed.tar.gz --exclude /home/dspace/tmp --exclude /home/dspace/.m2 --exclude /home/dspace/webapps /home/dspace/