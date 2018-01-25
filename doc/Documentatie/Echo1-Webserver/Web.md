# Documentatie Web

## Server gegevens

- Naam: Echo1
- IP-adress: 172.16.128.136
- Service: Publiek toegankelijke webserver en voorzieningen voor dynamische webapplicaties
- VLAN: 50
- Alias: www
- Verantwoordelijkheid: groep 5

## Gebruikte rollen

- [bertvv.httpd](https://galaxy.ansible.com/bertvv/httpd/)
- [bertvv.drupal](https://galaxy.ansible.com/bertvv/drupal/)

## Gebruikte variabelen
De variabelen die gebruikt zijn bij het opstellen van echo1 zijn hieronder opgelijst en de gevolgen die deze hebben genoteerd.

- Deze variabele zorgt ervoor dat de jusite diensten op de firewall doorgelaten worden:

```
rhbase_firewall_allow_services:
  - http
  - https
```

- Deze variabele declareerd de te gebruiken gegevens voor de drupaldatabase. De parameter ```drupal_database_host``` zorgt ervoor dat er geconnecteerd kan worden met de databank die op november1 gehost is:

```
drupal_database: 'echo1DB'
drupal_username: 'echo1'
drupal_password: 'echo1'
drupal_database_host: '172.16.128.7'
```

- Aangezien we met SELinux werken dient Apache toestemming te krijgen om te connecties over internet te maken en te connecteren met een databank op een externe server:

```
rhbase_selinux_booleans:
  - httpd_can_network_connect
  - httpd_can_network_connect_db
```
