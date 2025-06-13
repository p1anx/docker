FROM ubuntu:22.04

ARG USER_NAME=stm32
ARG UID=1000
ARG GID=1000
ARG MYWORK_DIR=/home/$USER_NAME
RUN groupadd -g $GID $USER_NAME && useradd -m -u $UID -g $GID -s /bin/bash $USER_NAME
# RUN mkdir $MYWORK_DIR
# RUN apt update -y && apt install -y wget xz-utils \
#   && wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz \
#   && tar xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz -C /usr/local/
RUN apt update -y \
  && apt install openssh-server fish vim git wget xz-utils build-essential sudo -y \
  && echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && apt install gcc-arm-none-eabi openocd usbutils -y \
  && rm -rf /var/lib/apt/lists/*

WORKDIR $MYWORK_DIR
USER $USER_NAME

CMD ["/bin/fish"]
  

