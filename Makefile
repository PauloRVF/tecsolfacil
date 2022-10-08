#!make
ecto_setup:
	docker compose run --rm tecsolfacil mix ecto.setup	

start:
	docker compose up -d

logs:
	docker compose logs -f tecsolfacil	

deps_get:
	docker compose run --rm tecsolfacil mix deps.get
	