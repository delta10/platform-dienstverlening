# Prerequisites

First install the ECK operator with:

```
kubectl create -f https://download.elastic.co/downloads/eck/2.9.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.9.0/operator.yaml
```

And then create the resources with:

```
kubectl apply -f ./helmreleases/openinwoner/eck/elasticsearch.yaml
```

Now prepare the Elasticsearch environment with:

```
ELASTIC_PASSWORD=$(kubectl get secret -n demodam-demo openinwoner-es-elastic-user -o go-template='{{.data.elastic | base64decode }}')
echo $ELASTIC_PASSWORD
```

And substitute the password in openinwoner-secrets.yaml

Load some mock data with:

```
python src/manage.py loaddata src/open_inwoner/conf/fixtures/django-admin-index.json --settings=open_inwoner.conf.staging
python src/manage.py loaddata src/open_inwoner/conf/fixtures/cms-pages.json --settings=open_inwoner.conf.staging
python src/manage.py loaddata src/open_inwoner/conf/fixtures/mail-editor.json --settings=open_inwoner.conf.staging
python src/manage.py loaddata src/open_inwoner/conf/fixtures/profile_apphook_config.json --settings=open_inwoner.conf.staging
python src/manage.py loaddata src/open_inwoner/questionnaire/fixtures/questionnaire_sampledata_2.json --settings=open_inwoner.conf.staging
```

Finally, to build the Elasticsearch index, run the following in the pod:

```
python src/manage.py search_index --rebuild
```
