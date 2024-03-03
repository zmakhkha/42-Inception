!/bin/sh
mysql_install_db
service mariadb start

mysql -u root -e "DROP DATABASE IF EXISTS test;"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS wordpress; GRANT ALL ON wordpress.* TO 'wordpress'@'%' IDENTIFIED BY 'wordpress';"
sudo mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('wordpress');"
mysql -u root -e "FLUSH PRIVILEGES;"
mysqladmin shutdown -pwordpress
exec mysqld --user=mysql