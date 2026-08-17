# Build the manager binary
FROM registry.access.redhat.com/ubi9/go-toolset@sha256:1a9bbbfa854931a97dbff276bd69dc0e32b36cb2fbce3b9813b2cf9892aa8d43 AS builder
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
RUN make build-cleanup-controller

FROM registry.access.redhat.com/ubi9/ubi-micro@sha256:aff810919642215e15c993b9bbc110dbcc446608730ad24499dafd9df7a8f8f4
WORKDIR /
COPY --from=builder /kyverno/cmd/cleanup-controller .
USER 65532:65532

ENTRYPOINT ["/cleanup-controller"]
