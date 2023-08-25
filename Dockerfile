# Ubuntu 20.04 as base image
FROM ubuntu:20.04

# define the directory to work in
WORKDIR /

# copy the requirements.txt file to the work directory
COPY requirements.txt .

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN DEBIAN_FRONTEND=noninteractive
# install dependencies in the same layer
RUN apt-get update \
    && apt-get install python3 -y \
    && apt-get install python3-pip -y \
    && apt-get install python3-pyaudio -y \
    && apt-get install python3-tk -y \
    && pip3 install --no-cache-dir -r requirements.txt
    
RUN apt-get install dbus-x11 -y \
    && apt-get install libcanberra-gtk-module -y

# Copy rest of the source code
COPY src/ src/

# EXPOSE the needed ports

# Running Command or Entry Point
#CMD python3 ./src/py-looper_v1.0.1.py
CMD /bin/bash