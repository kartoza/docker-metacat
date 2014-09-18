#docker run --name="metacat-postgis" -d -t kartoza/postgis

docker run -i\
	--name="saeon-metacat" \
	-p 8080:8080 \
        -p 80:80 \
	-d \
        --volume="/home/gavin/docker-metacat/volume:/usr/local/volume" \
        --link postgis:db \
        -t \
        kartoza/metacat /bin/bash
