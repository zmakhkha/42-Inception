#!/bin/sh

DB_NAME=$MDB_NAME
DB_USER=$MDB_USER
DB_PASS=$MDB_PASS

mysql_install_db
service mariadb start

mysql -u root -e "DROP DATABASE IF EXISTS test;"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME; GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';"
mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_PASS');"
mysql -u root -e "FLUSH PRIVILEGES;"
mysqladmin shutdown -p$DB_PASS
exec mysqld --user=mysql

