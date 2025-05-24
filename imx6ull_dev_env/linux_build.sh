#!/bin/bash 
make clean
make imx_v7_defconfig
make -j$(nproc)
