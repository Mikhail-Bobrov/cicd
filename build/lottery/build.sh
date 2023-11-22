#!/bin/bash

set -e

GIT_URL=git@git.:default/default.git
ENV=$2
BRANCH=$3
REGISTRY_URL=$5
REGISTRY_PROJECT=$4
PROJECT=$1
JAVA_VERSION=registry./bbsoft/bbsoft-ci:zulu-openjdk14

if [ -d "$PROJECT" ]; then
    rm -rf "$PROJECT"
fi
echo "$PROJECT - service $ENV - project $BRANCH - branch"
git clone $GIT_URL -b $BRANCH

if [[ $PROJECT == "application" || $PROJECT == "backoffice" ]]; then
    cd lotte*
else
    cd ${PROJECT}*
fi

git rev-parse --short HEAD > ../ci_commit_sha-${PROJECT}
cat ../ci_commit_sha-${PROJECT}

./gradlew build -x test
cd ..
docker build --build-arg JAVA_VERSION="${JAVA_VERSION}" -t "${REGISTRY_URL}/${REGISTRY_PROJECT}/application:${BRANCH}-${CI_PIPELINE_ID}-$(cat ci_commit_sha-${PROJECT})" -f Dockerfile-app .
docker push "${REGISTRY_URL}/${REGISTRY_PROJECT}/application:${BRANCH}-${CI_PIPELINE_ID}-$(cat ci_commit_sha-${PROJECT})"
docker build --build-arg JAVA_VERSION="${JAVA_VERSION}" -t "${REGISTRY_URL}/${REGISTRY_PROJECT}/backoffice:${BRANCH}-${CI_PIPELINE_ID}-$(cat ci_commit_sha-${PROJECT})" -f Dockerfile-backoffice .
docker push "${REGISTRY_URL}/${REGISTRY_PROJECT}/backoffice:${BRANCH}-${CI_PIPELINE_ID}-$(cat ci_commit_sha-${PROJECT})"
if [[ $PROJECT == "application" || $PROJECT == "backoffice" ]]; then
    rm -rf default
else
    rm -rf "$PROJECT"
fi
