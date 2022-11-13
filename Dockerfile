FROM dkimg/opencv:4.6.0-ubuntu

WORKDIR /app
RUN apt update && apt install -y gcc clang clang-tools cmake python3
RUN pip install -U pip wheel cmake
COPY requirements.txt ./
RUN apt-get update && apt-get install -y cmake

RUN apt-get -y update
RUN apt-get install -y --fix-missing \
    build-essential \
    cmake \
    gfortran \
    git \
    wget \
    curl \
    graphicsmagick \
    libgtk2.0-dev\
    libgraphicsmagick1-dev \
    pkg-config \
    libatlas-base-dev \
    libavcodec-dev \
    libavformat-dev \
    libgtk2.0-dev \
    libjpeg-dev \
    liblapack-dev \
    libswscale-dev \
    pkg-config \
    python3-dev \
    python3-numpy \
    software-properties-common \
    zip \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*

RUN cd ~ && \
    mkdir -p dlib && \
    git clone -b 'v19.9' --single-branch https://github.com/davisking/dlib.git dlib/ && \
    cd  dlib/ && \
    python3 setup.py install --yes USE_AVX_INSTRUCTIONS

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

