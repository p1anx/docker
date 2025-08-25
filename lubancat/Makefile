IMAGE_NAME := lubancat_dev
CONTAINER_NAME := lubancat_container
all:
	docker build --build-arg BASE_IMAGE=ubuntu:20.04 --network host -t $(IMAGE_NAME) .
	docker run -it --rm --name $(CONTAINER_NAME) $(IMAGE_NAME)
run:
	docker run -it --name $(CONTAINER_NAME) $(IMAGE_NAME)
clean:
	docker rm -f $(CONTAINER_NAME)
	docker rmi -f $(IMAGE_NAME)
