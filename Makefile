DOCKER_IMAGE=dict-validator

UID=$(shell id -u $(USER))
GID=$(shell id -g $(USER))

DOCKER=docker run --rm \
	    -v $(PWD):/project \
	    -u $(UID):$(UID) \
	    -w /project \
	    -it $(DOCKER_IMAGE)

docker-image:
	docker build -f build-scripts/Dockerfile \
	    --build-arg USER_UID=$(UID) \
	    --build-arg USER_GID=$(GID) \
	    -t $(DOCKER_IMAGE) .

connect:
	@$(DOCKER) /bin/bash

%: docker-image
	@$(DOCKER) make -f build-scripts/project.mk $@

.PHONY: docker-image connect