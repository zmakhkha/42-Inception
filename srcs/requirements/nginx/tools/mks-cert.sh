#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/zmakhkha.key -out /etc/nginx/zmakhkha.crt -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=zmakhkha.42.fr"