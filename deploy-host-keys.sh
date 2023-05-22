#!/bin/sh

set -e

# host keys
mkdir -p etc/ssh
ssh-keygen -A -f .
kubectl create -n kube-system secret generic sshd-host-keys --from-file=etc/ssh/ssh_host_{ecdsa,ed25519,rsa}_key{,.pub}
