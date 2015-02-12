#fetch the metacat and geoserver binaries the first time you run this by uncommenting these lines (and update the versions to the latest or the ones you want)
#wget -c http://knb.ecoinformatics.org/software/dist/metacat-bin-2.4.1.tar.gz -O metacat.tar.gz
#wget -c http://sourceforge.net/projects/geoserver/files/GeoServer/2.5.2/geoserver-2.5.2-war.zip/download -O geoserver.zip
docker build -t kartoza/metacat .
