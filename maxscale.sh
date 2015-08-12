#!/usr/bin/env bash

name="galera"

hosts=()
ids=()
cnt="$(docker ps | grep $name | wc -l)"
[[ $cnt -eq 0 ]] && echo "No galera containers running" && exit 1
for ((i=1; i<=cnt; i++)); do
    container_id=$(docker ps | grep "$name-$i" | awk '{print $1}')
    echo "container id : $container_id"
    ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress  }}' $container_id)
    echo "container ip : $ip" 
    echo "docker exec $c \"sed -i \"s|.*wsrep_cluster_address.*=.*|$address|g\" $mycnf\""
    docker exec $c sed -i "s|.*wsrep_cluster_address.*=.*|$address|g" $mycnf
    hosts+=($ip)
    ids+=($container_id)
done
