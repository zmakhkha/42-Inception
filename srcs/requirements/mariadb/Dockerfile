FROM debian:oldstable

RUN		apt-get update && apt-get upgrade -y \
&& apt-get install mariadb-server mariadb-client -y

RUN		mkdir -p /var/run/mysqld && \
chown -R mysql /var/run/mysqld && \
chmod -R 777 /var/run/mysqld


RUN		sed -i "s|127.0.0.1|0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

COPY	./tools/script.sh .
RUN		chmod +x script.sh
CMD		["bash", "./script.sh"]