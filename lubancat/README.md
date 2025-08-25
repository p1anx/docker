## Usage
0. build dockerfile
```bash
make
```
1. in host
mounting the folder in host is  neccessary.
```bash
mkdir lubancat_sdk
docker run -it -v ./lubancat_sdk:/home/rk/lubancat_sdk --name lubancat0 lubancat_dev
```

2. in `docker container`
```bash
sudo ./build.sh chip
sudo ./build.sh      #build all for uboot, kernel, rootfs
```

if you need to rebuild, run the following command.
```bash
sudo ./build.sh cleanall
```
