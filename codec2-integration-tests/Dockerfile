# Use Ubuntu instead of Alpine, because it has more familiar tools included.
FROM ubuntu:24.04
WORKDIR /root
RUN apt-get update
RUN apt-get install -y cmake git
RUN apt-get install -y curl python3 pipenv python3-pip python3-venv
RUN curl https://pyenv.run | bash

RUN git clone https://github.com/drowe67/codec2
WORKDIR /root/codec2
RUN git checkout 1.2.0
RUN mkdir build_linux
WORKDIR /root/codec2/build_linux
RUN cmake ..
RUN make install
RUN ldconfig
WORKDIR ..
WORKDIR ..

RUN mkdir pycodec2
COPY ../../ pycodec2/
WORKDIR pycodec2
  RUN pipenv install --dev
WORKDIR ..
