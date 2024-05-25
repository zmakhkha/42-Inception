#!/bin/sh

mysql_install_db
service mariadb start

mysql -u root -e "DROP DATABASE IF EXISTS test;"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MDB_NAME; GRANT ALL ON $MDB_NAME.* TO '$MDB_USER'@'%' IDENTIFIED BY '$MDB_PASS';"
# mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MDB_PASS');"
# mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MDB_PASS}';"
mysql -u root -e "FLUSH PRIVILEGES;"
mysqladmin shutdown -p$MDB_PASS
exec mysqld --user=mysql

