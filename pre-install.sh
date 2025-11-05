#!/bin/bash
kubectl create -f https://solr.apache.org/operator/downloads/crds/v0.9.1/all-with-dependencies.yaml
helm install --create-namespace -n solr-operator solr-operator apache-solr/solr-operator --version 0.9.1
