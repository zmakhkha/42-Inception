FROM debian:oldstable

RUN		apt-get update && \
apt-get upgrade -y && \
apt-get install nginx -y && \
apt-get install -y openssl


RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/zmakhkha.key -out /etc/nginx/zmakhkha.crt -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=zmakhkha.42.fr"
COPY	conf/ngnix.conf /etc/nginx/nginx.conf
EXPOSE	443
CMD		["nginx", "-g", "daemon off;"]