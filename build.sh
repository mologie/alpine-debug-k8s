#!/bin/sh
exec docker buildx build --platform linux/amd64,linux/arm64 -f Dockerfile -t ghcr.io/mologie/alpine-debug --push .
