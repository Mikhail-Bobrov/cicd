#!/bin/bash

set -e

GIT_URL=git@git
ENV=$2
BRANCH=$3
REGISTRY_URL=$5
REGISTRY_PROJECT=$4
PROJECT=$1
JAVA_VERSION=image/zulu-openjdk14

if [ -d "$PROJECT" ]; then
    rm -rf "$PROJECT"
fi
echo "$PROJECT - service $ENV - project $BRANCH - branch"
git clone $GIT_URL -b $BRANCH

cd ${PROJECT}*

git rev-parse --short HEAD > ../ci_commit_sha-${PROJECT}
cat ../ci_commit_sha-${PROJECT}

cd ..
docker build --build-arg JAVA_VERSION="${JAVA_VERSION}" -t "${REGISTRY_URL}/${REGISTRY_PROJECT}/${PROJECT}:${BRANCH}-${CI_PIPELINE_ID}-$(cat ci_commit_sha-${PROJECT})" .
docker push "${REGISTRY_URL}/${REGISTRY_PROJECT}/${PROJECT}:${BRANCH}-${CI_PIPELINE_ID}-$(cat ci_commit_sha-${PROJECT})"
rm -rf "$PROJECT"