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


select Host, User from mysql.user;
