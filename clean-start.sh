#!/bin/bash

echo "*** Starting cleanup for  fresh start...."
echo ""
#echo "initalize the my.cnf file..."
#rm my.cnf
#cp init.my.cnf my.cnf
#echo ""
echo "*** Stop and remove containers"
docker rm `docker stop galera-core-1`
#docker stop galera
#docker rm galera
echo "*** containers removed"
docker ps -a
echo "*** do remove files"
sudo rm -rf /mnt/data/ubuntu-pxc56/mysql-core/mysql-error.log
sudo rm -rf /mnt/data/ubuntu-pxc56/mysql-core/grastate.dat
echo "*** removed files" 
ls -la /mnt/data/ubuntu-pxc56/mysql-core/
