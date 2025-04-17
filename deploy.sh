#!/bin/sh

if [[ $# != 2 ]] ; then
    echo "Wrong number of arguments"
    exit 1
fi

BUILD_CONTEXT=$1
DEPLOY_CONTEXT=$2

echo "Setting Build Context..."
docker context use $BUILD_CONTEXT

echo "Building..."
docker build -t 0x6a616e/pef-backend backend/ 

echo "Pushing..."
docker push 0x6a616e/pef-backend:latest

echo "Deploying..."
docker context use $DEPLOY_CONTEXT
docker stack deploy -c ./compose.yaml pef
