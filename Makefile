# Makefile.docker contains the shared tasks for building, tagging and pushing Docker images.
# This file is included into the Makefile files which contain the Dockerfile files (E.g.
# kafka-base, kafka etc.).
#
# The DOCKER_ORG (default is name of the current user) and DOCKER_TAG (based on Git Tag,
# default latest) variables are used to name the Docker image. DOCKER_REGISTRY identifies
# the registry where the image will be pushed (default is Docker Hub).
DOCKERFILE_DIR     ?= ./
DOCKER_REGISTRY    ?= docker.io
DOCKER_ORG         ?= $(USER)
DOCKER_IMAGE       ?= zoo-entrance
DOCKER_TAG         ?= latest

all: docker_build docker_push

docker_build:
	# Build Docker image ...
	docker build -t $(DOCKER_ORG)/$(DOCKER_IMAGE):$(DOCKER_TAG) $(DOCKERFILE_DIR)

docker_tag:
	# Tag the $(BUILD_TAG) image we built with the given $(DOCKER_TAG) tag
	docker tag $(DOCKER_ORG)/$(DOCKER_IMAGE):$(DOCKER_TAG) $(DOCKER_REGISTRY)/$(DOCKER_ORG)/$(DOCKER_IMAGE):$(DOCKER_TAG)

docker_push: docker_tag
	# Push the $(DOCKER_TAG)-tagged image to the registry
	docker push $(DOCKER_REGISTRY)/$(DOCKER_ORG)/$(DOCKER_IMAGE):$(DOCKER_TAG)
