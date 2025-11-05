# Prerequisites

First install the ECK operator with:

```
kubectl create -f https://download.elastic.co/downloads/eck/2.9.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.9.0/operator.yaml
```

And then create the resources with:

```
kubectl apply -f ./helmreleases/kiss/eck/elasticsearch.yaml
kubectl apply -f ./helmreleases/kiss/eck/enterprisesearch.yaml
kubectl apply -f ./helmreleases/kiss/eck/kibana.yaml
```

Now prepare the Elasticsearch environment with:

```
ELASTIC_PASSWORD=$(kubectl get secret -n demodam-demo kiss-es-elastic-user -o go-template='{{.data.elastic | base64decode }}')
echo $ELASTIC_PASSWORD
```

And substitute the `ELASTIC_PASSWORD` in frontend-secrets.yaml.

Now setup a port-forward to fetch the public and private API key in Kibana:

```
kubectl -n demodam-demo port-forward deployments/kiss-kb 5601:5601
```

Go to https://localhost:5601/app/enterprise_search/app_search/credentials

You can login with elastic / $ELASTIC_PASSWORD.

Fetch the private and public API key and substitute `ENTERPRISE_SEARCH_PRIVATE_API_KEY` and `ENTERPRISE_SEARCH_PUBLIC_API_KEY` in frontend-secrets.yaml.

Now create the cronjobs with:

```
kubectl apply -f ./helmreleases/kiss/cronjobs/kennisbank.yaml
kubectl apply -f ./helmreleases/kiss/cronjobs/smoelenboek.yaml
kubectl apply -f ./helmreleases/kiss/cronjobs/vac.yaml
kubectl apply -f ./helmreleases/kiss/cronjobs/website.yaml
```