#!/bin/bash

set -euo pipefail

PUSH=${PUSH:-false}

# Currently only supports the quay.io/mtsre repository using the `mtsre+push` robot account credentials.
# You can extend this configuration by modifying the secret injected by Jenkins in app-interface:
# https://gitlab.cee.redhat.com/service/app-interface/-/blob/master/resources/jenkins/mt-sre/ci-ext/
# ---
# https://docs.docker.com/engine/reference/commandline/cli/#change-the-docker-directory
[[ "${PUSH}" == "true" ]] && export DOCKER_CONFIG="${DOCKER_CONF}"

for container_dir in $(find ${PWD} -type d); do
    # ignore non-compliant container_dir
    if [ ! -f "${container_dir}/commands.sh" ]; then
        continue
    fi

    # Change diretory and save current location on stack
    pushd ${container_dir} >/dev/null

    echo "Building ${container_dir}..."
    source commands.sh && build
    [[ "${PUSH}" == "true" ]] && push

    # Go back to old directory
    popd >/dev/null
done
