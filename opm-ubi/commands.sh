#!/bin/bash

export OPM_VERSION="v1.19.5"
export BASE_IMAGE="quay.io/app-sre/ubi8-ubi:8.6"
export REPO="quay.io/mtsre"
export IMAGE="opm-ubi"
export TAG="${OPM_VERSION}"

function build() {
    docker build \
        --build-arg=BASE_IMAGE="${BASE_IMAGE}" \
        --build-arg=OPM_VERSION="${OPM_VERSION}" \
        -t "${REPO}/${IMAGE}:${TAG}" .
}

function push() {
    docker push "${REPO}/${IMAGE}:${TAG}"
}
