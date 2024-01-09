FROM debian:trixie-slim

RUN apt-get update
RUN apt-get install nginx -y
RUN apt-get install -y openssl

COPY tools/mks-cert.sh /app/mks-cert.sh
RUN chmod +x /app/mks-cert.sh

RUN bash /app/mks-cert.sh
RUN chmod 644 /etc/nginx/zmakhkha.crt
RUN chmod 600 /etc/nginx/zmakhkha.key


COPY conf/ngnix.conf /etc/nginx/nginx.conf
RUN chmod 644 /etc/nginx/nginx.conf


COPY tools/index.html  /usr/share/nginx/html/index.html


EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]