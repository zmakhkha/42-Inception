FROM debian:oldstable

RUN		apt-get update && \
apt-get upgrade -y && \
apt-get install nginx -y


WORKDIR /etc/nginx
COPY	/conf/nginx.conf .

WORKDIR /var/www
# RUN rm -rf *
COPY conf/index.html .
EXPOSE	2100
CMD		["nginx", "-g", "daemon off;"]