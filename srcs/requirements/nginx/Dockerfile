FROM debian:oldstable

RUN apt-get update
RUN apt-get install nginx -y
RUN apt-get install -y openssl

COPY tools/mks-cert.sh /app/mks-cert.sh
RUN chmod +x /app/mks-cert.sh

RUN bash /app/mks-cert.sh
# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/zmakhkha.key -out /etc/nginx/zmakhkha.crt -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=zmakhkha.42.fr"
 
# RUN chmod 644 /etc/nginx/zmakhkha.crt
# RUN chmod 600 /etc/nginx/zmakhkha.key

COPY conf/ngnix.conf /etc/nginx/nginx.conf
# RUN chmod 644 /etc/nginx/nginx.conf

# RUN mkdir -p /usr/share/nginx
# WORKDIR /app
#COPY tools/wp-conf.sh /app/wp-conf.sh
#RUN chmod 644 /app/wp-conf.sh



EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]