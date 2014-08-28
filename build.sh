#fetch the metacat binary the first time you run this by uncommenting it
#wget -c http://knb.ecoinformatics.org/software/dist/metacat-bin-2.4.1.tar.gz -O metacat.tar.gz
#wget -c http://sourceforge.net/projects/geoserver/files/GeoServer/2.5.2/geoserver-2.5.2-war.zip/download -O geoserver.zip
docker build -t kartoza/metacat .
