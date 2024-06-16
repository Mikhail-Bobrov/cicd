#!/bin/bash

set -e

GIT_URL=git@git
GIT_DIR=default
ENV=$2
BRANCH=$3
REGISTRY_URL=$5
REGISTRY_PROJECT=$4
PROJECT=$1

if [ -d "$GIT_DIR" ]; then
    rm -rf "$GIT_DIR"
fi

echo -e "service - $PROJECT \nproject - $ENV \nbranch - $BRANCH"

git clone $GIT_URL -b $BRANCH

cd ${GIT_DIR}

if [[ $ENV == 'loto-preprod' ]]; then
    mv .env.preprod .env
fi

git rev-parse --short HEAD > ../ci_commit_sha-${PROJECT}
cat ../ci_commit_sha-${PROJECT}

docker build -t "${REGISTRY_URL}/${REGISTRY_PROJECT}/${PROJECT}:${BRANCH}-${CI_PIPELINE_ID}-$(cat ../ci_commit_sha-${PROJECT})" .
docker push "${REGISTRY_URL}/${REGISTRY_PROJECT}/${PROJECT}:${BRANCH}-${CI_PIPELINE_ID}-$(cat ../ci_commit_sha-${PROJECT})"
cd ..

rm -rf "$GIT_DIR"
