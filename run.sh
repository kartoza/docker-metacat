docker.io run --name="metacat-postgis" -t -d kartoza/postgis

docker.io run \
	--name="saeon-metacat" \
	--link osm-africa-postgis:osm-africa-postgis \
	-p 20007:22 \
	-p 20008:20008 \
	-p 20009:20009 \
	-d \
	-t kartoza/metacat
