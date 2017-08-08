#!/bin/bash
#
# Set /etc/hosts on all containers in a set so they know about each other.
#
TPREF="foo"

# Set list of container names from command argument list
clist=$*

# Get list of IP addresses for container names passed as argument
(
for n in ${clist} ; do
 nn=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${n}`
 echo ${n} ${nn}
done
) > ${TPREF}_001.txt

# Get /etc/hosts for each containter in list
(
for n in ${clist} ; do
 docker ${n} exec -t -i cat /etc/hosts | awk '{print "'${n}': "$0}'
done
) > ${TPREF}_002.txt

