MAKEFLAGS=--warn-undefined-variables

# Parameters
PORT ?= 127.0.0.1:5000

# Internal Variables
docker_image = imsardine/docker-mkdocs
docker_opts =

define docker_run
	docker run --rm -it \
	  --volume $(PWD):/workspace \
	  $(docker_opts) \
	  $(docker_image) $(1)
endef

setup:
	docker pull $(docker_image)

build:
	$(call docker_run,build --clean)

shell: docker_opts += --entrypoint --publish $(PORT):8000
shell:
	$(call docker_run,bash)

preview: docker_opts += --publish $(PORT):8000
preview:
	$(call docker_run,serve)
