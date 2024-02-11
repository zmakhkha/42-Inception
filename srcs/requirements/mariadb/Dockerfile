FROM debian:trixie-slim

RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install mariadb-server mariadb-client -y

RUN mkdir /run/mysqld
RUN chown -R mysql /var/run/mysqld
RUN chmod -R 777 /var/run/mysqld
#RUN  sed -i "s|127.0.0.1|0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf


EXPOSE 3306
CMD ["mysqld", "--user=mysql"]