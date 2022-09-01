#!/bin/sh
podman build --security-opt="seccomp=unconfined" -t strongswan -f Dockerfile .
