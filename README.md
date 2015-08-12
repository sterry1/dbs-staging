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
   *  TODO need to find a way to handle the bootstrapping of new cluster and 
   *  TODO setup of users and config files to enable cluster replication and load balancing.  

