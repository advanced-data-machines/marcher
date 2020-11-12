#!/bin/bash
echo "building --platform=linux/arm/v7,linux/amd64 "
docker buildx build --platform=linux/arm/v7,linux/amd64 -t admachines/marcher:latest .  --push