#!/usr/bin/env bash

# adds the volume mapping for mysql /var/lib/mysql directory
# as well as the my.cnf file with the cluster settings to be swapped out for /etc/mysql/my.cnf
# with bootstrap startup
image="agaveapi/ubuntu:pxc56"
container="galera"
container_datadir=/var/lib/mysql
host_datadir=/mnt/data/ubuntu-pxc56/mysql

[[ ! -d $host_datadir ]] && sudo mkdir -p $host_datadir
docker run -d --name="$container" -v $host_datadir:$container_datadir -v $(pwd)/my.cnf:/etc/mysql/my.cnf -v $(pwd)/trunc-core-data-7.23.sql:/var/lib/mysql/core-data.sql $image

