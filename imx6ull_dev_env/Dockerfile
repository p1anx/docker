FROM ubuntu:22.04

ARG IMX_LINUX_KERNEL_DIR=/root/imx_linux_kernel
ARG IMAGES_DIR=/root/images

ENV ARCH=arm
ENV CROSS_COMPILE=arm-linux-gnueabihf-

RUN mkdir $IMX_LINUX_KERNEL_DIR $IMAGES_DIR
COPY images $IMAGES_DIR
COPY linux_build.sh $IMX_LINUX_KERNEL_DIR
# COPY gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf.tar.xz .

RUN apt update -y \
  && apt install openssh-server fish vim git wget xz-utils build-essential -y \
  # && wget https://releases.linaro.org/components/toolchain/binaries/4.9-2017.01/arm-linux-gnueabihf/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf.tar.xz \
  && tar -xf $IMAGES_DIR/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf.tar.xz -C $IMAGES_DIR \
  && mv $IMAGES_DIR/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf /usr/local \
  && echo 'export PATH=$PATH:/usr/local/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf/bin' >> ~/.bashrc \
  && apt install gcc-9 -y \
  && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 2 \
  # && /etc/init.d/ssh start \
  && sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
  # install the requirement of build linux kernel\
  && apt install libncurses5-dev lzop bc -y \
  && apt install usbutils -y \
  && tar -jxvf /root/images/linux-imx-4.1.15-2.1.0-g3dc0a4b-v2.7.tar.bz2 -C $IMX_LINUX_KERNEL_DIR \
  && rm -rf /var/lib/apt/lists/*
  # && /bin/bash /root/images/linux_build.sh

  # && service ssh start


WORKDIR /root/imx_linux_kernel
RUN touch test.txt

CMD ["/bin/fish"]
