#!/usr/bin/env bash

name="galera"
user=root
pass=root123
port=4567
mycnf=/etc/mysql/my.cnf

exec_cmd() {
    cnt=0
    rc=1
    until [[ $cnt -eq 6 ]] || [[ $rc -eq 0 ]]
    do
        echo "Running [$cnt]: $@"
        "$@"
        rc=$?
        cnt=$(($cnt + 1))
        sleep 3
    done

    if [[ $rc -ne 0 ]]
    then
        echo "Failed: $@"
        return $rc
    fi
}

hosts=()
ids=()
address=""
cnt="$(docker ps | grep $name | wc -l)"
[[ $cnt -eq 0 ]] && echo "No galera containers running" && exit 1
for ((i=1; i<=cnt; i++)); do
    container_id=$(docker ps | grep "$name-$i" | awk '{print $1}')
    echo "container id : $container_id"
    ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress  }}' $container_id)
    echo "container ip : $ip" 
    hosts+=($ip)
    ids+=($container_id)
done

for ((i=cnt-1; i>=0; i--)); do
    address="${hosts[i]}:$port,$address"
done
echo "address's of cluster $address"
address="wsrep_cluster_address = gcomm://$address"
address=${address%?}
echo "** $address"
echo " start container loop"

for c in "${ids[@]}"; do
    echo "docker exec $c \"sed -i \"s|.*wsrep_cluster_address.*=.*|$address|g\" $mycnf\""
    echo "update cluster config"
    docker exec $c sed -i "s|.*wsrep_cluster_address.*=.*|$address|g" $mycnf
    echo "command done"
done
 
init_node=${hosts[0]}
unset hosts[0]

#for c in "${ids[@]}"; do
#    echo "docker exec $c \"rm -f /var/lib/mysql/grastate.dat\""
#    echo "rm grastate.dat for galera cluster init"
#    docker exec $c 'rm -f /var/lib/mysql/grastate.dat'
#    echo "docker exec $c \"service mysql restart\""
#    echo "restart mysql with cluster settings"
#    docker exec $c /etc/init.d/mysql restart
#    echo "command done"
#done

