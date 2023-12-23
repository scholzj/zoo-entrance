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

ifdef DOCKER_ARCHITECTURE
  DOCKER_PLATFORM = --platform linux/$(DOCKER_ARCHITECTURE)
  DOCKER_PLATFORM_TAG_SUFFIX = -$(DOCKER_ARCHITECTURE)
endif

all: docker_build docker_push

docker_build:
	echo "Building Docker image ..."
	docker build --no-cache $(DOCKER_PLATFORM) -t $(DOCKER_ORG)/$(DOCKER_IMAGE):$(DOCKER_TAG)$(DOCKER_PLATFORM_TAG_SUFFIX) $(DOCKERFILE_DIR)

docker_tag:
	echo "Tagging $(DOCKER_ORG)/$(DOCKER_IMAGE):$(DOCKER_TAG)$(DOCKER_PLATFORM_TAG_SUFFIX) to $(DOCKER_REGISTRY)/$(DOCKER_ORG)/$(DOCKER_IMAGE):$(DOCKER_TAG)$(DOCKER_PLATFORM_TAG_SUFFIX) ..."
	docker tag $(DOCKER_ORG)/$(DOCKER_IMAGE):$(DOCKER_TAG)$(DOCKER_PLATFORM_TAG_SUFFIX) $(DOCKER_REGISTRY)/$(DOCKER_ORG)/$(DOCKER_IMAGE):$(DOCKER_TAG)$(DOCKER_PLATFORM_TAG_SUFFIX)

docker_push: docker_tag
	echo "Pushing $(DOCKER_REGISTRY)/$(DOCKER_ORG)/$(DOCKER_IMAGE):$(DOCKER_TAG)$(DOCKER_PLATFORM_TAG_SUFFIX) ..."
	docker push $(DOCKER_REGISTRY)/$(DOCKER_ORG)/$(DOCKER_IMAGE):$(DOCKER_TAG)$(DOCKER_PLATFORM_TAG_SUFFIX)

docker_amend_manifest:
	# Create / Amend the manifest
	docker manifest create $(DOCKER_REGISTRY)/$(DOCKER_ORG)/$(DOCKER_IMAGE):$(DOCKER_TAG) --amend $(DOCKER_REGISTRY)/$(DOCKER_ORG)/$(DOCKER_IMAGE):$(DOCKER_TAG)$(DOCKER_PLATFORM_TAG_SUFFIX)

docker_push_manifest:
	# Push the manifest to the registry
	docker manifest push $(DOCKER_REGISTRY)/$(DOCKER_ORG)/$(DOCKER_IMAGE):$(DOCKER_TAG)
