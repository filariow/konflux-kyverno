# Build the manager binary
FROM registry.access.redhat.com/ubi9/go-toolset@sha256:7b1828de52c3bac600a71b81996bf748776a456181a45e2b329b39702cf6486f AS builder
ARG TARGETOS
ARG TARGETARCH

WORKDIR /kyverno

# Copy the Go Modules manifests
COPY --chown=1001:0 . .
# cache deps before building and copying source so that we don't need to re-download as much
# and so that source changes don't invalidate our downloaded layer
RUN go mod download

# Build
RUN make build-kyverno-init

FROM registry.access.redhat.com/ubi9/ubi-micro@sha256:f5c5213d2969b7b11a6666fc4b849d56b48d9d7979b60a37bb853dff0255c14b
WORKDIR /
COPY --from=builder /kyverno/cmd/kyverno-init .
USER 65532:65532

ENTRYPOINT ["/kyverno-init"]
