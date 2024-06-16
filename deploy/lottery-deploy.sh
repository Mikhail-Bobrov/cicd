#!/bin/bash

set -e

ENV=$1
BRANCH=$2
REGISTRY_URL=$4
REGISTRY_PROJECT=$3
NAMESPACE=$5
DEPLOY_GCP=$6
REGION=$7

echo "${REGISTRY_URL}/${REGISTRY_PROJECT}/application:${BRANCH}-${CI_PIPELINE_ID}-$(cat build/lottery/ci_commit_sha-lottery)" > deploy/images/application
echo "${REGISTRY_URL}/${REGISTRY_PROJECT}/backoffice:${BRANCH}-${CI_PIPELINE_ID}-$(cat build/lottery/ci_commit_sha-lottery)" > deploy/images/backoffice
#cat deploy/images/application
if [ $DEPLOY_GCP == true ]
then
    gcloud container clusters get-credentials $REGISTRY_PROJECT-gke --region $REGION --project $REGISTRY_PROJECT
else
    export KUBECONFIG=~/.kube/$ENV
fi
kubectl get no && kubectl config current-context
helm template -f deploy/project/${ENV}/application/Chart.yaml deploy/
helm template -f deploy/project/${ENV}/backoffice/Chart.yaml deploy/
helm upgrade --install application -n $NAMESPACE -f deploy/project/${ENV}/application/Chart.yaml  deploy/
helm upgrade --install backoffice -n $NAMESPACE -f deploy/project/${ENV}/backoffice/Chart.yaml  deploy/
kubectl rollout  status -n $NAMESPACE  $(kubectl get deployments.apps  -n $NAMESPACE  -l name=backoffice -o name) --timeout=180s
kubectl rollout  status -n $NAMESPACE  $(kubectl get deployments.apps  -n $NAMESPACE  -l name=application -o name) --timeout=180s