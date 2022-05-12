#!/bin/bash

set -e

PUSH=false

for container_dir in $(find ${PWD} -type d); do
    container_name=$(basename ${container_dir})

    # ignore non-compliant container_dir
    if [ ! -f "${container_dir}/commands.sh" ]; then
        continue
    fi

    # Change diretory and save current location on stack
    pushd ${container_dir} >/dev/null

    echo "Building ${container_dir}..."
    source commands.sh && build
    [[ "${PUSH}" == true ]] && push

    # Go back to old directory
    popd >/dev/null
done
