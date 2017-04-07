#Dockerfile for python-opencv-contrib

# Pull base image
FROM ubuntu:16.10

MAINTAINER Carlos Alvarez <candres.alv@gmail.com>

# Constants that define verions
ENV CV_VERSION 3.2.0
ENV PYTHON_VERSION 2.7
ENV CORES 4


# Donwload prerequisites
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    pkg-config \
    libswscale-dev \
    python$PYTHON_VERSION-dev \
    python$PYTHON_VERSION-numpy \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libjasper-dev \
    libavformat-dev \
    && apt-get -y clean all \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

# Download and compile openCV
RUN wget https://github.com/Itseez/opencv/archive/$CV_VERSION.zip -O opencv.zip \
    && unzip -q opencv.zip \
    && wget https://github.com/Itseez/opencv_contrib/archive/$CV_VERSION.zip -O opencv_contrib.zip \
    && unzip -q opencv_contrib.zip \
    && mkdir /opencv-$CV_VERSION/build \
    && cd /opencv-$CV_VERSION/build \
    && cmake -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib-$CV_VERSION/modules .. \
    && make -j$CORES \
    && make install \
    && rm /opencv.zip \
    && rm /opencv_contrib.zip \
    && rm -r /opencv-$CV_VERSION

## Define default command.
CMD ["bash"]
