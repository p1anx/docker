IMAGE_NAME := myu_test
CONTAINER_NAME := myu0
all:
	docker build --network host -t $(IMAGE_NAME) .
	docker run -it $(CONTAINER_NAME) $(IMAGE_NAME)
clean:
	docker rm -f $(CONTAINER_NAME)
	docker rmi -f $(IMAGE_NAME)
