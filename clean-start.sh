#!/bin/bash

echo "*** Starting cleanup for  fresh start...."
echo ""
echo "initalize the my.cnf file..."
rm my.cnf
cp init.my.cnf my.cnf
echo ""
echo "*** Stop and remove containers"
# docker rm `docker stop $(docker ps -aq)`
docker stop galera
docker rm galera
echo "*** containers removed"
docker ps -a
echo "*** remove mysql directory"
sudo rm -rf /mnt/data/ubuntu-pxc56/mysql/
echo "*** removed mysql directory" 
ls -la /mnt/data/ubuntu-pxc56/mysql/
