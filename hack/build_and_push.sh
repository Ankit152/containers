#!/bin/bash

set -euo pipefail

# Currently only supports the quay.io/mtsre repository using the `mtsre+push` robot account credentials.
# You can extend this configuration by modifying the secret injected by Jenkins in app-interface:
# https://gitlab.cee.redhat.com/service/app-interface/-/blob/master/resources/jenkins/mt-sre/ci-ext/
function login() {
    docker --config "${DOCKER_CONF}" login quay.io/mtsre
}

###
### Runtime
###

PUSH=${PUSH:-false}

[[ "${PUSH}" == "true" ]] && login

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
