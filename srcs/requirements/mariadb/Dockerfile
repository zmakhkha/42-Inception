FROM debian:trixie-slim

RUN apt-get update
RUN apt-get install mariadb-server mariadb-client -y

RUN mkdir /run/mysqld
RUN chown -R mysql /var/run/mysqld
RUN chmod -R 777 /var/run/mysqld
RUN  sed -i "s|bind-address            = 127.0.0.1|bind-address            = 0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

RUN /etc/init.d/mariadb start

#RUN     mysql -u mysql -e "DROP DATABASE IF EXISTS test;"
#RUN     mysql -u mysql -e "CREATE USER IF NOT EXISTS 'zmakhkha'@'%' IDENTIFIED BY 'lalatfo';" && \
#    mysql -u mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'zmakhkha'@'%';" && \
#    mysql -u mysql -e "FLUSH PRIVILEGES;" && \
#    mysqladmin shutdown -p 'lalatfo'

CMD ["mysqld", "--user=mysql"]
EXPOSE 3306