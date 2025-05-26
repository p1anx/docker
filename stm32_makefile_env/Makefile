IMAGE_NAME := stm32_env_img
CONTAINER_NAME := stm32_env0
all:
	docker build --network host -t $(IMAGE_NAME) .
	# docker run -it --name $(CONTAINER_NAME) $(IMAGE_NAME)
up:
	docker compose up -d
down:
	docker compose down
clean:
	docker rm -f $(CONTAINER_NAME)
	docker rmi -f $(IMAGE_NAME)
