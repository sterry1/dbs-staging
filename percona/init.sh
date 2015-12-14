#/usr/bin/env bash
set -x
if [[ ! -f /var/lib/mysql/ibdata1 ]]; then
    mysql_install_db
    /usr/bin/mysqld_safe &
    sleep 10s

    x="root123"
    cat > "/tmp/secure.sql" << EOF
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test; DELETE FROM mysql.db WHERE DB='test' OR DB='test\\_%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$x' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY '$x' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'172.17.42.1' IDENTIFIED BY '$x' WITH GRANT OPTION;
CREATE USER 'agaveapi'@'%' IDENTIFIED BY 'd3f@ult$';
GRANT ALL PRIVILEGES ON *.* TO 'agaveapi'@'%';
CREATE USER 'maxscale'@'%' IDENTIFIED BY 'd3f@ult$';
GRANT ALL PRIVILEGES ON *.* TO 'maxscale'@'%';
GRANT SELECT ON `mysql`.`db` TO 'maxscale'@'%';
GRANT SELECT ON `mysql`.`user` TO 'maxscale'@'%';
CREATE USER 'apim_vdj_admin'@'%' IDENTIFIED BY 'p@ssword';
GRANT ALL PRIVILEGES ON `userdb_vdjserver-org`.* TO 'apim_vdj_admin'@'%';
GRANT ALL PRIVILEGES ON `regdb_vdjserver-org`.* TO 'apim_vdj_admin'@'%';
GRANT ALL PRIVILEGES ON `apimgtdb_vdjserver-org`.* TO 'apim_vdj_admin'@'%';
CREATE USER 'apim_aip_admin'@'%' IDENTIFIED BY 'qw3zbc9H4';
GRANT ALL PRIVILEGES ON `userdb_araport-org`.* TO 'apim_aip_admin'@'%';
GRANT ALL PRIVILEGES ON `regdb_araport-org`.* TO 'apim_aip_admin'@'%';
GRANT ALL PRIVILEGES ON `apimgtdb_araport-org`.* TO 'apim_aip_admin'@'%';
CREATE USER 'apim_iplnt_admin'@'%' IDENTIFIED BY 'tM476zp3R195';
GRANT ALL PRIVILEGES ON `userdb_iplantc-org`.* TO 'apim_iplnt_admin'@'%';
GRANT ALL PRIVILEGES ON `regdb_iplantc-org`.* TO 'apim_iplnt_admin'@'%';
GRANT ALL PRIVILEGES ON `apimgtdb_iplantc-org`.* TO 'apim_iplnt_admin'@'%';
CREATE USER 'apim_tacc_admin'@'%' IDENTIFIED BY 'r73vKj29614';
GRANT ALL PRIVILEGES ON `userdb_tacc-prod`.* TO 'apim_tacc_admin'@'%';
GRANT ALL PRIVILEGES ON `regdb_tacc-prod`.* TO 'apim_tacc_admin'@'%';
GRANT ALL PRIVILEGES ON `apimgtdb_tacc-prod`.* TO 'apim_tacc_admin'@'%';
CREATE USER 'apim_irec_admin'@'%' IDENTIFIED BY 'dbke843XskQG';
GRANT ALL PRIVILEGES ON `userdb_irec`.* TO 'apim_irec_admin'@'%';
GRANT ALL PRIVILEGES ON `regdb_irec`.* TO 'apim_irec_admin'@'%';
GRANT ALL PRIVILEGES ON `apimgtdb_irec`.* TO 'apim_irec_admin'@'%';
FLUSH PRIVILEGES;
EOF
    echo "*** Securing MySQL ($host)..."
    /usr/bin/mysql -uroot  -h127.0.0.1 < /tmp/secure.sql; rm -f /tmp/secure.sql

    killall -15 mysqld_safe mysqld
    chown -R mysql.mysql /var/lib/mysql
    sleep 10s
fi
# mount fix
grep -v rootfs /proc/mounts > /etc/mtab
/usr/bin/mysqld_safe &

sleep infinity
 #/usr/bin/supervisord
