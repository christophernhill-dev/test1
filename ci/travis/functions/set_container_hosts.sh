#!/bin/bash
#
# Set /etc/hosts on all containers in a set so they know about each other.
#

# Get list of IP addresses for container names passed as argument
clist=$*
for n in ${clist} ; do
 nn=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${n}`
 echo ${n} ${nn}
done
