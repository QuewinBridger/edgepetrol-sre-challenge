#!/bin/sh

set -e # Stop script from running if there are any errors

IMAGE=${DOCKER_USERNAME}/edgepetrol-sre-challenge
APP_VERSION=${VERSION}
echo ${IMAGE}
echo "github tagged APP_VERSION:"
echo ${APP_VERSION}



echo "Looking for an existing release tag against this commit"
if [ ! -z ${APP_VERSION} ]
then
  echo "1) Build image"
  docker build -t ${IMAGE} -f ./src/dockerfile ./src

  echo "2) tag previously built image with latest"
  echo "Building and pushing image as latest to docker hub"
  
  docker tag ${IMAGE} ${IMAGE}:edgepetrol-sre-challenge
  docker push ${IMAGE}:edgepetrol-sre-challenge

  echo "3) tag previously built image with version"
  echo "A VERSION was specified on this commit, therefore publishing tagged docker image APP_VERSION: ${APP_VERSION}"
  docker tag ${IMAGE} ${IMAGE}:${APP_VERSION}-edgepetrol-sre-challenge
  docker push ${IMAGE}:${APP_VERSION}-edgepetrol-sre-challenge

else
  echo "This commit was not tagged with a VERSION, therefore not pushing an image to docker"
fi

