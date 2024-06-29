#!/bin/bash

adduser --home /var/www ${FTP_USER}
echo ${FTP_USER}:${FTP_PWD} | chpasswd

echo "
write_enable=YES" >> /etc/vsftpd.conf

service vsftpd stop
/usr/sbin/vsftpd /etc/vsftpd.conf