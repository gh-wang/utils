#####################################################################
# INSTALL OPENCV ON RASPBERRY PI                                    #
#                                                                   #
# Reference:                                                        #
# - https://www.pyimagesearch.com/2018/09/19/pip-install-opencv/    #
# - piwheels: https://www.piwheels.org/                             #
#                                                                   #
# OpenCV versions:                                                  #
#  - opencv-python:                                                 #
#    Contains the main modules of the OpenCV library.               #
#  - opencv-contrib-python:                                         #
#    Contains both the main modules and the contrib modules.        #
#  - opencv-python-headless: for headless system                    #
#    Same as opencv-python w/o GUI functionality.                   #
#  - opencv-contrib-python-headless: for headless system            #
#    Same as opencv-contrib-python w/o GUI functionality.           #
#                                                                   #
# Verify                                                            #
# - nano /etc/pip.conf:                                             #
# - [global]                                                        #
# - extra-index-url=https://www.piwheels.org/simple#                #
#                                                                   #
# To run:                                                           #
# - ./install_opencv_from_wheel.sh                                         #
#                                                                   #
# For Windows user:                                                 #
# - sed -i -e 's/\r$//' rpi_install_opencv.sh                       #
#####################################################################

# |-----------------------------------------------------------------|
# | Raspbian                    | OpenCV       | Test | Last test   |
# |-----------------------------|--------------|------|-------------|
# | 2018-11-13-raspbian-stretch | OpenCV 3.4.4 | OK   | 30 Jan 2019 |
# |-----------------------------------------------------------------|

# ---------------------------------------------------------
# 1. KEEP SYSTEM UP TO DATE
# ---------------------------------------------------------
sudo apt-get -y update
sudo apt-get -y upgrade

# ---------------------------------------------------------
# 2. INSTALL THE DEPENDENCIES
# ---------------------------------------------------------

# 2.1 Build tools:
sudo apt-get install -y build-essential cmake unzip pkg-config

# Media I/O:
sudo apt-get install -y libjpeg-dev libpng12-dev libtiff5-dev libjasper-dev

# Install libusb for uvc video
sudo apt-get install -y libusb-1.0-0-dev


# 2.2 OpenCV dependencies
sudo apt-get install -y libhdf5-dev libhdf5-serial-dev
sudo apt-get install -y libqtwebkit4 libqt4-test

sudo apt-get install -y libatlas-base-dev libjasper-dev
sudo apt-get install -y libqtgui4
sudo apt-get install -y python3-pyqt5

# ---------------------------------------------------------
# 3. Python3 UPDATE
# ---------------------------------------------------------
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py

# ---------------------------------------------------------
# 4. INSTALL OPENCV
# ---------------------------------------------------------
# sudo pip3 install opencv-contrib-python
sudo python3 -m pip install opencv-contrib-python
