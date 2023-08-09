.ONESHELL:
all: start
start:
	sudo mkdir -p $(WP_VOLUME) $(DB_VOLUME)
	cd srcs
	docker compose up -d
stop:
	cd srcs
	docker compose stop
status:
	cd srcs
	docker compose ps
logs:
	cd srcs
	docker compose logs --tail=100
clean:
	cd srcs
	docker compose down -v --rmi local
fclean: clean
	sudo rm -rf $(WP_VOLUME) $(DB_VOLUME)
restart: stop start
rebuild: clean start 
.PHONY: all start stop status logs clean fclean restart
include srcs/.env
