## Agave staging compose files

This project contains a combination of docker-compose files and bash scripts needed to setup the database layer for Agaveapi services 
for percona-cluster and maxscale loadbalancer on agave-dbs-staging.tacc.utexas.edu.  

### Project Files
    * Dockerfile
    * README.md
    * add-core-users.sql
    * bootstrap-cluster.sh
    * build.sh
    * dbs-staging-beanstalk-mongo.yml
    * dbs-staging-percona-core.yml
    * id_rsa
    * id_rsa.pub
    * init.sh
    * maxscale.sh
    * my.cnf
    * pxc-MaxScale.cnf
    * start-servers.sh
    * supervisord.conf
    * trunc-core-data-7.23.sql

### Prerequisites (constructed with)
    * Docker 1.7.1
    * Docker-compose 1.3.2

### Setup

    * for clean start
    * stop/remove containers
    * docker rm $(docker stop $(docker ps -aq))
    * remove images
    * docker rmi $(docker images -q)
    * remove mysql directories
    * sudo rm -rf /mnt/data/ubuntu-pxc56/mysql-*

### build the image
    ./build.sh

### startup 2 containers and initialze mysql servers w/vol mount.
    ./start-servers.sh 2

### stop mysql wo stopping containers.
    docker exec galera-1 service mysql stop
    docker exec galera-2 service mysql stop

### remove the galera dat file
    sudo rm /mnt/data/ubuntu-pxc56/mysql-*/grastate.dat

### start up the cluster with bootstrap
    ./bootstrap-cluster.sh

### restart mysql instances with clustering setup
    docker exec galera-1 service mysql bootstrap-pxc
    docker exec galera-2 service mysql start 

### verify startup of database
    docker exec galera-1 mysql -uroot -proot123 -e "show databases;"

### show status of cluster
    docker exec galera-1 mysql -uroot -proot123 -e "show status like '%wsrep%'"
    wsrep_cluster_conf_id	2
    wsrep_cluster_size	2

### copy user and data sql to volume mount
    sudo cp add-core-users.sql trunc-core-data-7.23.sql /mnt/data/ubuntu-pxc56/mysql-1

### run sql script for users on bootstrap galera-1
    docker exec galera-1 mysql -uroot -proot123 -e "source /var/lib/mysql/add-core-users.sql;"

### verify
    docker exec galera-1 mysql -uroot -proot123 -e "select User, Host from mysql.user;"

### run sql to add agave-api db with truncated data
    docker exec galera-1 mysql -uroot -proot123 -e "source /var/lib/mysql/trunc-core-data-7.23.sql;"

### verify
    docker exec galera-1 mysql -uroot -proot123 -e "show databases;"
    docker exec galera-1 mysql -uroot -proot123 -e "use agave-api;select id from systems;"

### run the maxscale configuration setup based on previous steps
    ./maxscale.sh

### bring maxscale up with docker compose
    docker-compose -f dbs-staging-percona-core.yml up -d

### access cluster thru maxscale on whatever host you are using
     mysql -uagaveapi -pd3f@ult$ -P3301 -h129.114.7.140 -e "use agave-api;select id from softwares where id < 100;"

    Copyright (c) 2000, 2015, Oracle and/or its affiliates. All rights reserved.

    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    mysql> exit

