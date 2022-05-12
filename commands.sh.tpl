#!/bin/bash

export REPO="quay.io/mtsre"
export IMAGE="myimage"
export TAG="latest"

# command that will be used to build your container
function build() {
  docker build \
    -t "${REPO}/${IMAGE}:${TAG}" .
}

# command that will be used to push your container
function push() {
  docker push "${REPO}/${IMAGE}:${TAG}"
}
