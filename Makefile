MAKEFLAGS=--warn-undefined-variables

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

shell:
	$(call docker_run,)

preview: docker_opts += --publish 8000:8000
preview:
	$(call docker_run,pipenv run mkdocs serve)

build:
	$(call docker_run,pipenv run mkdocs build --clean)
