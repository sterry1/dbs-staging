#!/bin/bash

echo "*** Starting cleanup for  fresh start...."
echo ""
echo "*** Stop and remove containers"
docker rm `docker stop $(docker ps -aq)`
echo "*** containers removed"
docker ps -a
echo "*** remove mysql directory"
sudo rm -rf /mnt/data/ubuntu-pxc56/mysql/
echo "*** removed mysql directory" 
ls /mnt/data/ubuntu-pxc56/mysql/
