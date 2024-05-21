# syntax=docker/dockerfile:1
ARG BASE_IMAGE=quay.io/projectquay/golang:1.20
ARG TARGET_PLATFORM=linux/amd64

FROM ${BASE_IMAGE} AS builder
WORKDIR /app
COPY . .
RUN GOOS=$(echo ${TARGET_PLATFORM} | cut -d'/' -f1) \
    GOARCH=$(echo ${TARGET_PLATFORM} | cut -d'/' -f2) \
    go build -o myapp ./...

FROM alpine:latest AS linux
WORKDIR /root/
COPY --from=builder /app/myapp .
CMD ["./myapp"]

FROM alpine:latest AS linux_arm
WORKDIR /root/
COPY --from=builder /app/myapp .
CMD ["./myapp"]

FROM mcr.microsoft.com/windows/nanoserver:latest AS windows
WORKDIR /root/
COPY --from=builder /app/myapp.exe .
CMD ["./myapp.exe"]
