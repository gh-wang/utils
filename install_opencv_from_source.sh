#!/bin/bash
#####################################################################
# INSTALL OPENCV ON RASPBERRY PI                                    #
#                                                                   #
# Reference:                                                        #
# - https://milq.github.io/install-opencv-ubuntu-debian/            #
# - Raspbian Stretch: Install OpenCV 3+ Python on your Raspberry Pi #
#   https://www.pyimagesearch.com/2017/09/04/                       #
#      aspbian-stretch-install-opencv-3-python-on-your-raspberry-pi #
#                                                                   #
# For Windows user:                                                 #
# - sed -i -e 's/\r$//' rpi_install_opencv.sh                       #
#                                                                   #
# To run:                                                           #
# - ./install_opencv_from_source.sh                                 #
#####################################################################

# |-----------------------------------------------------------------|
# | Raspbian                    | OpenCV       | Test | Last test   |
# |-----------------------------|--------------|------|-------------|
# | 2018-11-13-raspbian-stretch | OpenCV 3.4.3 | OK   | 06 Dec 2018 |
# | 2018-11-13-raspbian-stretch | OpenCV 4.0.1 | OK   | 06 Jan 2019 |
# |-----------------------------------------------------------------|

# OpenCV Version
VERSION='3.4.3'

# 1. KEEP SYSTEM UP TO DATE
sudo apt-get -y update
sudo apt-get -y upgrade

# 2. INSTALL THE DEPENDENCIES

# Build tools:
sudo apt-get install -y build-essential cmake unzip pkg-config

# Media I/O:
sudo apt-get install -y libjpeg-dev libpng12-dev libtiff5-dev libjasper-dev

# Video I/O:
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install -y libxvidcore-dev libx264-dev

# GUI with GTK
sudo apt-get install -y libgtk-3-dev
sudo apt-get install -y libcanberra-gtk*

# Matrix operation libraries:
sudo apt-get install -y libatlas-base-dev gfortran

# Python3:
sudo apt-get install -y python3-dev
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py

# videodev.h header file for MJPG-Streamer has been replaced by videodev2.h
# To make MJPG-Streamer happy you have to create a symbolic link by
sudo ln -s /usr/include/linux/videodev2.h /usr/include/linux/videodev.h

# 3. INSTALL THE LIBRARY

# create opencv folder
cd ~
mkdir opencv
cd opencv

# download opencv source files
wget -O opencv.zip https://github.com/opencv/opencv/archive/$VERSION.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/$VERSION.zip
unzip opencv.zip
unzip opencv_contrib.zip

# create build folder
cd opencv-$VERSION
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-$VERSION/modules \
    -D ENABLE_NEON=ON \
    -D ENABLE_VFPV3=ON \
    -D BUILD_TESTS=OFF \
    -D BUILD_PERF_TESTS=OFF \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D INSTALL_C_EXAMPLES=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D WITH_LIBV4L=ON ..

# increase SWAP space size from CONF_SWAPSIZE=100 to 2048
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=2048/g' /etc/dphys-swapfile

# restart the swap service
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start

make -j4

sudo make install
sudo ldconfig

# restore SWAP space size to CONF_SWAPSIZE=100
sudo sed -i 's/CONF_SWAPSIZE=2048/CONF_SWAPSIZE=100/g' /etc/dphys-swapfile

# restart the swap service
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start
