#!/bin/bash

export PY_MTCLI_VERSION="1.27.0"
export REPO="quay.io/mtsre"
export IMAGE="validate-imageset"

export TAG="${PY_MTCLI_VERSION}"

function build() {
    docker build -t "${REPO}/${IMAGE}:${TAG}" .
}

function push() {
    docker push "${REPO}/${IMAGE}:${TAG}"
}
