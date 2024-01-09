touch docker-compose.yml
mkdir srcs
mkdir srcs/requirements
mkdir srcs/requirements/bonus
mkdir srcs/requirements/tools

mkdir srcs/requirements/wordpress
mkdir srcs/requirements/mariadb
mkdir srcs/requirements/nginx

mkdir srcs/requirements/mariadb/conf
mkdir srcs/requirements/mariadb/tools
touch srcs/requirements/mariadb/Dockerfile
touch srcs/requirements/mariadb/.dockerignore

mkdir srcs/requirements/nginx/conf
mkdir srcs/requirements/nginx/tools
touch srcs/requirements/nginx/Dockerfile
touch srcs/requirements/nginx/.dockerignore

mkdir srcs/requirements/wordpress/conf
mkdir srcs/requirements/wordpress/tools
touch srcs/requirements/wordpress/Dockerfile
touch srcs/requirements/wordpress/.dockerignore

mkdir srcs/requirements/bonus/redis
mkdir srcs/requirements/bonus/Adminer
mkdir srcs/requirements/bonus/webSite
mkdir srcs/requirements/bonus/ftpServer
mkdir srcs/requirements/bonus/cAdvisor