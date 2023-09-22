#!/bin/bash

NAMESPACE="default"
LABEL=$1
PROJECT=$2
TIMEOUT="120s"
INTERVAL="10"
COUNT=0

if [[ $PROJECT == "gcp-dev" ]]; then
    NAMESPACE="default"
elif [[ $PROJECT == "dc-preprod" ]]; then
    NAMESPACE="bbsoft"
elif [[ $PROJECT == "dc-stage1" ]]; then
    NAMESPACE="stage1"
fi

echo "start checking state of pods ${LABEL}"
sleep 10
kubectl wait --for=condition=Ready -n $NAMESPACE pod -l name=${LABEL} --timeout=${TIMEOUT}
status_code=$?

if [ $status_code -eq 0 ]; then
    echo "SERVICE ${LABEL} deployed"
    kubectl get pods -n $NAMESPACE -l name=${LABEL} -o custom-columns="POD:metadata.name,STATUS:status.phase"
    exit 0
else
    echo "something went wrong, watch logs"
    echo "status code is $status_code"
    kubectl get pods -n $NAMESPACE -l name=${LABEL} -o custom-columns="POD:metadata.name,STATUS:status.phase"
    exit 0
fi

