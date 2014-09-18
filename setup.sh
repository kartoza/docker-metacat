#assume starting with a base Ubuntu machine

#install general requirements
apt-get install git apt-cacher-ng postgresql-client

#install Docker. If you have issues with this site try the Russian mirror listed on the Docker website. 
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A
echo "deb https://get.docker.io/ubuntu docker main " > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install lxc-docker


