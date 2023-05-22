#!/bin/sh
exec docker build . -f Dockerfile -t ghcr.io/mologie/alpine-debug
