# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG OPM_VERSION
ARG BASE_IMAGE

# stage 1: copy opm + grpc_health_probe from regular opm image
FROM quay.io/operator-framework/opm:$OPM_VERSION as opm

# stage 2: output UBI image
FROM $BASE_IMAGE

# OPM requirements for a base image: https://github.com/operator-framework/operator-registry/blob/master/alpha/action/generate_dockerfile.go#L42-L63
COPY --from=opm /bin/opm /bin/opm
COPY --from=opm /bin/grpc_health_probe /bin/grpc_health_probe
