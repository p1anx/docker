# docker
# Introduction
This is for imx6ull embeded linux development.
# Requirements
- Download the files of `arm-linux-gnueabihf-gcc`, `linux-imx-4.1.15`, `uboot-imx-2016` to directory `images`
```shel
wget https://github.com/p1anx/docker/releases/download/linux_images_tools/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf.tar.xz
wget https://github.com/p1anx/docker/releases/download/linux_images_tools/linux-imx-4.1.15-2.1.0-g3dc0a4b-v2.7.tar.bz2
wget https://github.com/p1anx/docker/releases/download/linux_images_tools/uboot-imx-2016.03-2.1.0-g0ae7e33-v1.7.tar.bz2
```

# Usage
- build the image
```bash
docker build --network host -t imx6ull_dev_img .
```
- run the container
```bash
docker run -it --privileged=true -v /dev/bus/usb:/dev/bus/usb --name imx6ull_container imx6ull_dev_img
```

For `Makefile`, clean the image and container using `make clean` command
# reference
- [docker 1](https://hlyani.github.io/notes/docker/mount_usb_to_docker.html)

