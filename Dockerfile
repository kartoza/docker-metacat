#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM ubuntu:trusty
MAINTAINER Gavin Fleming<gavin@kartoza.com>

#docker docs advise against this:
#RUN  export DEBIAN_FRONTEND=noninteractive
#ENV  DEBIAN_FRONTEND noninteractive
#this is not recommended either but at least for the moment allows e.g. tomcat to be start with init.d script. 
RUN  dpkg-divert --local --rename --add /sbin/initctl
RUN  ln -s /bin/true /sbin/initctl

# Use local cached debs from host (saves your bandwidth!)
# Change ip below to that of your apt-cacher-ng host
# Or comment this line out if you do not with to use caching
ADD 71-apt-cacher-ng /etc/apt/apt.conf.d/71-apt-cacher-ng

RUN apt-get -y update
#RUN hostname saeonmetacat.kartoza.com

#-------------Application Specific Stuff ----------------------------------------------------

RUN apt-get -y install unzip default-jre-headless default-jre apache2 libapache2-mod-jk tomcat7
RUN echo 'ServerName saeonmetacat.kartoza.com' >> /etc/apache2/apache2.conf
ADD metacat.tar.gz /tmp
ADD geoserver.zip /tmp/
#restore metacat backup. Must write to /var/metacat
ADD var_metacat_backup_1Sept2014.tar.gz /
#we changed the context from knb to metacat:
RUN mv /var/metacat/.knb /var/metacat/.metacat
#ADD metacat.properties /var/metacat/.metacat/
RUN chown -R tomcat7:tomcat7 /var/metacat
RUN cp /tmp/metacat.war /var/lib/tomcat7/webapps
RUN unzip /tmp/geoserver.zip -d /var/lib/tomcat7/webapps
RUN cp /tmp/debian/jk.conf /etc/apache2/mods-available/
ADD volume/metacat/workers.properties /etc/apache2/
RUN a2dismod jk
RUN a2enmod jk
ADD volume/metacat/metacat-site.conf /etc/apache2/sites-available/
RUN a2dissite 000-default
RUN a2ensite metacat-site
#ENTRYPOINT service tomcat7 start
EXPOSE 8080
EXPOSE 80
ADD volume/metacat/server.xml /var/lib/tomcat7/conf/server.xml
ADD volume/metacat/catalina.properties /etc/tomcat7/catalina.properties
#this was the trick that got it workign after hours of pain. On 27 aug 2014 'service tomcat7 start' worked but after an update no longer!
# http://stackoverflow.com/questions/24265354/tomcat7-in-debianwheezy-docker-instance-fails-to-start
ADD run_services.sh /root/run_services.sh
RUN chmod +x /root/run_services.sh

#build with this commented out if you want to be able to attach to it later
CMD ["/root/run_services.sh"]

#ENTRYPOINT service tomcat7 start  && tail -f /var/lib/tomcat7/logs/catalina.out


