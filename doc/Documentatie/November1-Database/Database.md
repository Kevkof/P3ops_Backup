# Documentatie November1

## Server gegevens

- Naam: `november1`
- IP-adres: `172.16.128.7`
- Service: `db`
- VLAN: `30`
- Alias: `db`
- Verantwoordelijkheid: `Team 5`

## Gebruike rollen

- [bertvv.mariadb](https://galaxy.ansible.com/bertvv/mariadb)

## Uitleg gebruikte variabelen

Er zijn enkele variabelen gedefinieerd in `ansible/host_vars/november1.yml`. Hieronder verklaren we wat deze doen:

- Onderstaande variabele geeft aan welke **poorten** de firewall moet openzetten om de dbserver toegankelijk te maken van op het netwerk.

```yaml
rhbase_firewall_allow_services:
  - mysql
```

- Onderstaande variabele geeft aan dat de DB toegankelijk moet zijn vanop elk ip address en niet enkel localhost.

```yaml
mariadb_bind_address: '0.0.0.0'
```

- Onderstaande variabele maakt **2 databases** aan, een voor echo1 en een voor mike1, allebij worden ze **ingeladen** met data uit de bestanden echo1DBSetup.sql en mike1DBSetup.sql.

```yaml
mariadb_databases:
  - name: echo1DB
    init_script: ./files/echo1DBSetup.sql
  - name: mike1DB
    init_script: ./files/mike1DBSetup.sql
```

- Onderstaande variabele maakt **3 db gebruikers** aan, een voor echo1 en een voor mike1 en een administrator. De administrator heeft toegang tot elke database en ook alle rechten. De gebruiken **echo1** heeft enkel rechten op echo1DB en de gebruiken **mike1** heeft enkel rechten op mike1DB. De gebruikers mike1 en echo1 kunnen ook enkel vanop hun eigen server aan hun database.

```yaml
mariadb_users:
  - name: november1
    password: november1
    priv: '*.*:ALL,GRANT'
    host: '172.16.128.%'
  - name: echo1
    password: echo1
    priv: 'echo1DB.*:ALL'
    host: '172.16.128.136'
  - name: mike1
    password: mike1
    priv: 'mike1DB.*:ALL'
    host: '172.16.128.6'
```

- Onderstaande variabele is voor de monitor services.

```yaml
beats_config_file: files/servers.yml
```
