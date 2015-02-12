#comment out the /bin/bash if you don't need to connect to the container
#also add -i if you need it to run in interactive mode
docker run --name="saeon-metacat" \
	-p 8080:8080 \
        -p 80:80 \
	-d \
        --volume="/home/gavin/docker-metacat/volume:/usr/local/volume" \
        --link fd4af211544b:db \
        --restart=on-failure \
        -t \
        kartoza/metacat:productionFeb12_2015 /root/run_services.sh #/bin/bash
