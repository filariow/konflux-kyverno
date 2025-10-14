# Build the manager binary
FROM registry.access.redhat.com/ubi9/go-toolset@sha256:7b1828de52c3bac600a71b81996bf748776a456181a45e2b329b39702cf6486f AS builder
ARG TARGETOS
ARG TARGETARCH

WORKDIR /kyverno

# Copy the Go Modules manifests
COPY --chown=1001:0 . .
# cache deps before building and copying source so that we don't need to re-download as much
# and so that source changes don't invalidate our downloaded layer
WORKDIR /kyverno
RUN go mod download

# Build
RUN make build-kyverno

FROM registry.access.redhat.com/ubi9/ubi-micro@sha256:f45ee3d1f8ea8cd490298769daac2ac61da902e83715186145ac2e65322ddfc8
WORKDIR /
COPY --from=builder /kyverno/cmd/kyverno .
USER 65532:65532

ENTRYPOINT ["/kyverno"]
