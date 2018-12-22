MAKEFLAGS=--warn-undefined-variables
PORT ?= 5000

# Internal Variables
docker_image = dev-notes.local
docker_opts =

define docker_run
	docker run --rm -it \
	  --volume $(PWD):/workspace \
	  $(docker_opts) \
	  $(docker_image) $(1)
endef

setup:
	docker build -t $(docker_image) .

shell: docker_opts += --publish $(PORT):8000
shell:
	$(call docker_run,)

preview: docker_opts += --publish $(PORT):8000
preview:
	$(call docker_run,pipenv run mkdocs serve)

build:
	$(call docker_run,pipenv run mkdocs build --clean)
