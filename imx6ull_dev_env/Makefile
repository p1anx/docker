IMAGE_NAME := imx6ull_dev_img
CONTAINER_NAME := imx6ull_container
all:
	docker build --network host -t $(IMAGE_NAME) .
	docker run -it $(CONTAINER_NAME) $(IMAGE_NAME)
clean:
	docker rm -f $(CONTAINER_NAME)
	docker rmi -f $(IMAGE_NAME)
