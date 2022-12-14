# Builder Image
FROM python:3.10-slim-bullseye AS compile

# Install Dependencies
RUN apt-get -y update
RUN apt-get install -y --fix-missing \
  build-essential \
  cmake \
  gfortran \
  git \
  wget \
  curl \
  graphicsmagick \
  libgraphicsmagick1-dev \
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

ENV CFLAGS=-static
RUN pip3 install --upgrade pip && \
  git clone -b 'v19.24' --single-branch https://github.com/davisking/dlib.git && \
  cd dlib/ && \
  python3 setup.py install --set BUILD_SHARED_LIBS=OFF --set USE_AVX_INSTRUCTIONS=1

# Install Dlib
# RUN cd ~ && \
#   mkdir -p dlib && \
#   git clone -b 'v19.24' --single-branch https://github.com/davisking/dlib.git dlib/ && \
#   cd  dlib/ && \
#   python3 setup.py install --yes USE_AVX_INSTRUCTIONS

RUN pip3 install face_recognition

# Add our packages
# ENV PATH="/opt/venv/bin:$PATH"
