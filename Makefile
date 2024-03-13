all : up

up : 
	@docker-compose -f srcs/docker-compose.yml up -d

down : 
	@docker-compose -f srcs/docker-compose.yml down
	@docker volume prune -f


build : 
	@docker-compose -f srcs/docker-compose.yml build

stop : 
	@docker-compose -f srcs/docker-compose.yml stop

start : 
	@docker-compose -f srcs/docker-compose.yml start

rmi : 
	@docker rmi $(docker images)

rmv:
	@docker volume rm $(docker volume ls)

prune:
	docker system prune

stat : 
	@docker ps
re : down  rmv prune build up