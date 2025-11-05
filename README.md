# Platform Dienstverlening

## Introductie

Platform Dienstverlening is een gezamenlijke ontwikkeling van de gemeenten Den Haag en Utrecht, gericht op het aanbieden van een samenhangende digitale infrastructuur op basis van open standaarden. Door het combineren van componenten als een formulierenbouwer, een inwonerportaal, een zaakregistratie en aanverwante bouwstenen ontstaat een krachtig platform dat processen rondom aanvragen, meldingen en zaakgericht werken ondersteunt. Het doel is om niet langer losse systemen te beheren, maar één geïntegreerde dienst te bieden die gemeenten helpt om efficiënter te werken, inwoners beter te bedienen en innovatie te versnellen.

### Applicaties

- GZAC
- KISS
- NL Portal
- Open Formulieren
- Open Inwoner Portaal
- GPP-WOO

### Registraties

- Open Zaak
- Open Klant
- Open Archiefbeheer
- Open Notificaties
- Open Product
- Objecten
- Objecttypen

## Lokaal aan de slag

Installeer eerst de Flux CLI:

```
brew install fluxcd/tap/flux
```

Bootstrap je lokale Flux cluster:

```
flux check --pre
flux install
```

Installeer nu de Solr operator met:

```
./pre-install.sh
```

En voeg alle resources toe aan je cluster:

```
./apply.sh
```

Als de PostgreSQL database is opgestart, voer het volgende nog uit:

```
POSTGRES_PASSWORD=$(cat "$POSTGRES_POSTGRES_PASSWORD_FILE")
for db in objecten objecttypen openzaak openinwoner zac; do
    PGPASSWORD="$POSTGRES_PASSWORD" psql -U postgres -d "$db" -c "CREATE EXTENSION IF NOT EXISTS postgis;"
done
```
