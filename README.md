docker-metacat
==============

A docker container that runs Metacat (https://knb.ecoinformatics.org/#tools) with supporting components of Apache, Tomcat and Geoserver. 

install general requirements

```
./setup.sh
```
To set up apt-cacher-ng to minimise bandwidth and time usage when doing multiple builds then 

```
cp 71-apt-cacher-ng.template 71-apt-cacher-ng
```

then edit 71-apt-cacher-ng to match the IP of your host. 

The development scenario involved restoring from an existing Metacat instance. Adapt this as necessary for your restore or if you are doing a fresh install only. 

In volume/metacat, review these files and adjust if necessary to your situation. They will be baked into the Docker image when it is built. They are Apache and Tomcat configuration files that need modification according to the Metacat documentation: 

* catalina.properties
* metacat-site.conf
* server.xml
* workers.properties

volume/backups is there to receive backup files from the container

Ensure the backup of the previous installation's /var/metacat directory is in the base directory as a tar.gz file. 

Before the first build, open build.sh and uncomment the wget lines. This will ensure that the MetaCat and Geoserver installers are fetched once. Then comment the wget lines again so the installers don't get downloaded every time you build. 

To build the image do:

```
./build.sh
```

To run a container do:

```
./run.sh
```

Your Metacat container includes all components except the database. You will need PostgreSQL. If you want to set it up in another container then build https://github.com/kartoza/docker-postgis and run the orchestration script in its run.sh. 

Then create a metacat database and restore your metacat backup into it. 

Then when you configure Metacat through the web, point to your PostGIS container and the restored database.  

To use the Metacat container, open your browser at http:<yourdomain>/metacat.
To configure Metacat, go to http:<yourdomain>/metacat/admin 
Geoserver should be available at http:<yourdomain>/geoserver

Gavin Fleming (gavin@kartoza.com)
August 2014
