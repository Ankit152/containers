# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG OPM_VERSION
ARG BASE_IMAGE

# stage 1: copy opm + grpc_health_probe from regular opm image
FROM quay.io/operator-framework/opm:$OPM_VERSION as opm

# stage 2: output UBI image
FROM $BASE_IMAGE

# OPM requirements for a base image: https://github.com/operator-framework/operator-registry/blob/5566e4b6832a7fc08c12d3c79fc0a0b8c6a2e7aa/alpha/action/generate_dockerfile.go#L42-L63
COPY --from=opm /bin/opm /bin/opm
COPY --from=opm /bin/grpc_health_probe /bin/grpc_health_probe

# This image doesn't need to run as root user
#USER 1001

#EXPOSE 50051

#ENTRYPOINT ["/bin/registry-server"]
#CMD ["--database", "/bundles.db"]

LABEL io.k8s.display-name="OpenShift Operator Registry" \
      io.k8s.description="This is a UBI version to serve as the base for operator catalog API containers." \
      maintainer="Managed Tenants SRE <sd-mt-sre@redhat.com>" \
      summary="Operator Registry runs in a Kubernetes or OpenShift cluster to provide operator catalog data to Operator Lifecycle Manager."
