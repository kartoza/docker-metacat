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

#RUN apt-get -y install unzip openjdk-7-jdk apache2 libapache2-mod-jk tomcat7 
RUN apt-get -y install unzip openjdk-6-jre-headless openjdk-6-jre apache2 libapache2-mod-jk tomcat6
ADD metacat.tar.gz /tmp
ADD geoserver.zip /tmp/
RUN mkdir /var/metacat
RUN chown -R tomcat6:tomcat6 /var/metacat
RUN cp /tmp/metacat.war /var/lib/tomcat6/webapps
RUN unzip /tmp/geoserver.zip -d /var/lib/tomcat6/webapps
#ENV GEOSERVER_HOME /opt/geoserver
#ENTRYPOINT service tomcat7 start
EXPOSE 8080

#uncomment AJP element in <tomcat_home>/conf/server.xml

#CMD service tomcat7 restart  && tail -f /var/lib/tomcat7/logs/catalina.out


