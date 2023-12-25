#!/bin/bash

set -e

GIT_URL=git@git
ENV=$2
BRANCH=$3
REGISTRY_URL=$5
REGISTRY_PROJECT=$4
PROJECT=$1
RELEASE=$6

if [ $RELEASE == "true" ]; then
   git clone $GIT_URL -b master
   cd helm-belbet
   git status
   echo "${REGISTRY_URL}/${REGISTRY_PROJECT}/${PROJECT}:${BRANCH}-${CI_PIPELINE_ID}-$(cat ../ci_commit_sha-${PROJECT})" > deploy/images/${PROJECT}
   cat deploy/images/${PROJECT}
   git status
   git add deploy/images/${PROJECT}
   git commit -m "Auto-commit release image version for ${PROJECT}"
   git push origin master
fi
echo "Release - $RELEASE"
echo "Nothing to do"
