#!/bin/bash

export REPO="quay.io/mtsre"
export IMAGE="registry"
export TAG="v2"

# command that will be used to build your container
function build() {
    # Bypass Jenkins dockerhub block by loading the image from tar.gz and
    # populating the local cache
    docker load <registry-v2.tar.gz
    docker build \
        -t "${REPO}/${IMAGE}:${TAG}" .
}

# command that will be used to push your container
function push() {
    docker push "${REPO}/${IMAGE}:${TAG}"
}
