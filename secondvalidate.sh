 docker exec galera mysql -uroot -proot123 -e "show status like '%wsrep%'" | grep wsrep_cluster_size

