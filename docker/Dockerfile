ARG BASE_CONTAINER=nvidia/cuda
ARG CUDA_VERSION=11.8.0
ARG LINUX_VERSION=ubuntu22.04
FROM ${BASE_CONTAINER}:${CUDA_VERSION}-devel-${LINUX_VERSION}

RUN apt update \
  && apt install -y git cmake python3 python3-pip \
  && apt autoclean

RUN python3 -m pip install cython cupy-cuda11x

CMD ["bash"]
