#!/bin/bash

/etc/init.d/tomcat7 start
sleep 10
/etc/init.d/apache2 start
# The container will run as long as the script is running, that's why
# we need something long-lived here
exec tail -f /var/log/tomcat7/catalina.out
