#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM ubuntu:trusty
MAINTAINER Gavin Fleming<gavin@kartoza.com>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN  dpkg-divert --local --rename --add /sbin/initctl
#RUN  ln -s /bin/true /sbin/initctl

# Use local cached debs from host (saves your bandwidth!)
# Change ip below to that of your apt-cacher-ng host
# Or comment this line out if you do not with to use caching
ADD 71-apt-cacher-ng /etc/apt/apt.conf.d/71-apt-cacher-ng

RUN apt-get -y update

#-------------Application Specific Stuff ----------------------------------------------------

RUN apt-get -y install default-jre-headless default-jre apache2 libapache2-mod-jk tomcat7
ADD metacat.tar.gz /tmp
RUN mkdir /var/metacat
RUN chown -R tomcat7:tomcat7 /var/metacat
RUN cp /tmp/metacat.war /var/lib/tomcat7/webapps
EXPOSE 8080

#uncomment AJP element in <tomcat_home>/conf/server.xml
#this was the trick that got it workign after hours of pain. On 27 aug 2014 'service tomcat7 start' worked but after an update no longer!
# http://stackoverflow.com/questions/24265354/tomcat7-in-debianwheezy-docker-instance-fails-to-start
ADD run_tomcat.sh /root/run_tomcat.sh
RUN chmod +x /root/run_tomcat.sh

CMD ["/root/run_tomcat.sh"]

#ENTRYPOINT service tomcat7 start  && tail -f /var/lib/tomcat7/logs/catalina.out

#ENTRYPOINT 

