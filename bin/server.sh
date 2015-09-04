#!/usr/bin/env bash

# adds the volume mapping for mysql /var/lib/mysql directory
# as well as the my.cnf file with the cluster settings to be swapped out for /etc/mysql/my.cnf
# with bootstrap startup
type="core"
num=1
image="agaveapi/ubuntu:pxc56"
container="galera"
container_datadir=/var/lib/mysql
host_datadir=/mnt/data/ubuntu-pxc56/mysql-$type

[[ ! -d $host_datadir ]] && sudo mkdir -p $host_datadir
docker run -d --name="$container-$type-$num" -v $host_datadir:$container_datadir -v $(pwd)/sql/trunc-core-data-7.23.sql:/tmp/core-data.sql  -v $(pwd)/percona/my.cnf:/etc/mysql/my.cnf -p 3301:3306 -p 3302:4444 -p 3303:4567 $image

