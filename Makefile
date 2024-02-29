all : up

up : 
	@docker-compose -f srcs/docker-compose.yml up -d

down : 
	@docker-compose -f srcs/docker-compose.yml down

build : 
	@docker-compose -f srcs/docker-compose.yml build

stop : 
	@docker-compose -f srcs/docker-compose.yml stop

start : 
	@docker-compose -f srcs/docker-compose.yml start

stat : 
	@docker ps
re : down build up