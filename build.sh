#!/bin/bash

DEFAULT_VAULT_VERSION="1.13.2"
DEFAULT_PUSH="n"

read -p "Input vault version (default version: $DEFAULT_VAULT_VERSION): " VAULT_VERSION
read -p "Push docker image to registry(y/n (default 'n'))? " PUSH

DOCKER_USER="bydan"
IMAGE_NAME="vault"

if [ -z "$VAULT_VERSION" ]; then
  VAULT_VERSION=${DEFAULT_VAULT_VERSION}
fi

if [ -z "$PUSH" ]; then
  PUSH=${DEFAULT_PUSH}
fi

echo
echo "---------------------------------------------------------------------------------------"
echo "Build docker image ${DOCKER_USER}/${IMAGE_NAME}:${VAULT_VERSION}"
echo "---------------------------------------------------------------------------------------"
docker build --build-arg VAULT_VERSION=${VAULT_VERSION} -t ${DOCKER_USER}/${IMAGE_NAME}:${VAULT_VERSION} .

if [ "$PUSH" = "y" ]; then
  echo
  echo "---------------------------------------------------------------------------------------"
  echo "Push docker images ${DOCKER_USER}/${IMAGE_NAME}:${VAULT_VERSION} to docker registry"
  echo "---------------------------------------------------------------------------------------"
  docker push ${DOCKER_USER}/${IMAGE_NAME}:${VAULT_VERSION}
fi
