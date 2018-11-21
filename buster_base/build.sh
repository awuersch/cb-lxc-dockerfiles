#!/bin/bash

set -eu -o pipefail

REGISTRY=${REGISTRY-"rg1.tony.wuersch.name:443"}
REPO=${REPO-"buster_base"}
TAR_FILE=rootfs.tar

# build
TEMP_DIR=$(mktemp -d)
cp * $TEMP_DIR
docker build --pull -t $REPO -f $TEMP_DIR/Dockerfile.build $TEMP_DIR
docker create --name $REPO $REPO
docker export $REPO > $TEMP_DIR/$TAR_FILE
docker build -t $REGISTRY/$REPO $TEMP_DIR
rm -rf $TEMP_DIR

# clean
docker rmi -f $REPO || true
docker rm -f $REPO || true
