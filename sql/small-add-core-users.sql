CREATE USER 'agaveapi'@'%' IDENTIFIED BY 'd3f@ult$';
GRANT ALL PRIVILEGES ON *.* TO 'agaveapi'@'%';
CREATE USER 'maxscale'@'%' IDENTIFIED BY 'd3f@ult$';
GRANT ALL PRIVILEGES ON *.* TO 'maxscale'@'%';
GRANT SELECT ON `mysql`.`db` TO 'maxscale'@'%';
GRANT SELECT ON `mysql`.`user` TO 'maxscale'@'%';
CREATE USER 'apim_dev_admin'@'%' IDENTIFIED BY 'p@ssword';
GRANT ALL PRIVILEGES ON *.* TO 'apim_dev_admin'@'%';

FLUSH PRIVILEGES;


select Host, User from mysql.user;
