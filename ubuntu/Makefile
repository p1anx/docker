IMAGE_NAME := ubuntu_test
CONTAINER_NAME := u_test0
all:
	docker build --network host -t $(IMAGE_NAME) .
	# docker run -it --name $(CONTAINER_NAME) $(IMAGE_NAME)
up:
	docker compose up -d
	# docker run -it --name $(CONTAINER_NAME) $(IMAGE_NAME)
down:
	docker compose down
in:
	docker start $(CONTAINER_NAME)
	docker exec -it $(CONTAINER_NAME) /bin/bash
clean:
	docker rm -f $(CONTAINER_NAME)
	docker rmi -f $(IMAGE_NAME)
