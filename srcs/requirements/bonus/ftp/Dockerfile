FROM debian:oldstable


RUN apt update -y

RUN apt install vsftpd -y

COPY ./tools/script.sh /
RUN	chmod +x script.sh


CMD ["/script.sh"]