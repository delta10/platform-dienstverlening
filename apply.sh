#!/bin/bash
kubectl create namespace demodam-demo || true

for d in */ ; do
  if [ -f "$d/kustomization.yaml" ]; then
    kubectl apply -k "$d"
  fi
done
