#!/bin/bash

set -e

GIT_URL=git@git.ridotto.by:bbsoft/bbsoft-client.git
PROJECT=$2
BRANCH=$3
REGISTRY_URL=$5
REGISTRY_PROJECT=$4
SERVICE=$1

if [ -d "$SERVICE" ]; then
    rm -rf "$SERVICE"
fi
echo "$SERVICE - service $PROJECT - project $BRANCH - branch"
git clone $GIT_URL -b $BRANCH

if [ "$PROJECT" = "dc-preprod" ]; then
  cp bbsoft-client/env_dc-preprod bbsoft-client/.env
elif [ "$PROJECT" = "gcp-dev" ]; then
  cp bbsoft-client/env_gcp-dev bbsoft-client/.env
elif [ "$PROJECT" = "dc-stage1" ]; then
  cp bbsoft-client/env_dc-stage1 bbsoft-client/.env
fi

cd ${SERVICE}*

git rev-parse --short HEAD > ../ci_commit_sha-${SERVICE}
cat ../ci_commit_sha-${SERVICE}

docker build  -t "${REGISTRY_URL}/${REGISTRY_PROJECT}/${SERVICE}:${BRANCH}-${CI_PIPELINE_ID}-$(cat ../ci_commit_sha-${SERVICE})" .
docker push "${REGISTRY_URL}/${REGISTRY_PROJECT}/${SERVICE}:${BRANCH}-${CI_PIPELINE_ID}-$(cat ../ci_commit_sha-${SERVICE})"
cd ..
rm -rf "$SERVICE"
