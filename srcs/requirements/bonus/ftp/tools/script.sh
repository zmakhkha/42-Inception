#!/bin/bash

adduser --home /var/www ${FTP_USER}

echo ${FTP_USER}:${FTP_PWD} | chpasswd

sed -i -r "s/#write_enable=YES/write_enable=YES/1"   /etc/vsftpd.conf

echo "
local_enable=YES
allow_writeable_chroot=YES
pasv_enable=YES
local_root=/var/www ${FTP_USER}
pasv_min_port=40000
pasv_max_port=40005
userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf

service vsftpd stop

/usr/sbin/vsftpd /etc/vsftpd.conf