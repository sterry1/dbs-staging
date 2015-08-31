docker exec galera  mysql -uroot -proot123 -e "show databases;"
docker exec galera  mysql -uroot -proot123 -e "select Host, User from mysql.user;"
