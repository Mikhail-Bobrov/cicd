#!/bin/bash

set -e

GIT_URL=git@git.ridotto.by:bbsoft/backoffice-ui.git
PROJECT=$2
BRANCH=$3
REGISTRY_URL=$5
REGISTRY_PROJECT=$4
SERVICE=$1
JAVA_VERSION=registry.ridotto.by/bbsoft/bbsoft-ci:zulu-openjdk14

if [ -d "$SERVICE" ]; then
    rm -rf "$SERVICE"
fi
echo "$SERVICE - service $PROJECT - project $BRANCH - branch"
git clone $GIT_URL -b $BRANCH

if [[ $SERVICE == "application" || $SERVICE == "backoffice" ]]; then
    cd lotte*
else
    cd ${SERVICE}*
fi
######### this file isnt ready ############

git rev-parse --short HEAD > ../ci_commit_sha-${SERVICE}
cat ../ci_commit_sha-${SERVICE}

cd ..
docker build --build-arg JAVA_VERSION="${JAVA_VERSION}" -t "${REGISTRY_URL}/${REGISTRY_PROJECT}/${SERVICE}:${BRANCH}-${CI_PIPELINE_ID}-$(cat ci_commit_sha-${SERVICE})" .
docker push "${REGISTRY_URL}/${REGISTRY_PROJECT}/${SERVICE}:${BRANCH}-${CI_PIPELINE_ID}-$(cat ci_commit_sha-${SERVICE})"
if [[ $SERVICE == "application" || $SERVICE == "backoffice" ]]; then
    rm -rf lottery
else
    rm -rf "$SERVICE"
fi
