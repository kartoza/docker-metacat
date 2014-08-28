#docker run --name="metacat-postgis" -d -t kartoza/postgis

docker run \
	--name="saeon-metacat" \
	-p 8080:8080 \
	-d \
	-t kartoza/metacat

 #--link metacat-postgis:saeon-metacat \

