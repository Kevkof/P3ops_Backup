# Documentatie mike1

## Server gegevens
- Naam: mike1
- IP-adres:
  - Mike1: 172.16.128.6
  - Netmask: 255.255.0.0
- Service: contentmanagementsysteem (cms)
- Alias:
  - Mike1: cms
- Verantwoordelijkheid: `Team 5B`

## Gebruikte rollen

- https://galaxy.ansible.com/bertvv/httpd/
- https://galaxy.ansible.com/bertvv/wordpress/
- https://galaxy.ansible.com/markwilde/php-mcrypt/
- https://galaxy.ansible.com/markwilde/php/

## Uitleg gebruikte variabelen

Alle gebruikte variabelen voor mike1 staan in `ansible/host_vars/mike1.yml`.

* Onderstaande variable zorgt ervoor dat de services `http` en `https` worden toegelaten door de firewall.

```yaml
rhbase_firewall_allow_services:
  - http
  - https
```

* Deze variabele zal ervoor zorgen dat de firewall de poort 389 via tcp zal openzetten en toestaan.

```yaml
rhbase_firewall_allow_ports:
  - 389/tcp
```

* Via deze variabele zal apache scripting uitvoeren via `php`. `Php` is de enige toegelaten.

```yaml
httpd_scripting: 'php'
```

* Onderstaande variabele gaat de documentroot van apache wijzigen naar `'/usr/share/wordpress'` in plaats van het default path `/var/www/html`.

```yaml
httpd_DocumentRoot: '/usr/share/wordpress'
```

* Via deze variabelen zal de connectie met de databank worden aangemaakt. `Database_host` zal hier het ip adres krijgen van `november1`. `Database` krijgt hierbij de naam van de database voor wordpress. Bij `user` en `password` komen de gebruikersnaam en wachtwoord voor de connectie te leggen.

```yaml
wordpress_database_host: 172.16.128.7
wordpress_database: mike1DB
wordpress_user: mike1
wordpress_password: mike1
```

* Extra plugins voor wordpress of themes zijn altijd mogelijk via de onderstaande variabelen. Deze kunden gevonden worden van de Wordpress Plugins en Themes directory. Ze worden voorzien van een naam en mogelijks een versie.

```yaml
wordpress_plugins:
  - name: ldap-login-for-intranet-sites
  - name: simple-ldap-login
  - name: authLdap

wordpress_themes:
  - name: xcel
    version: 1.0.9
```

* Voor metricbeat is er een extra variable die verwijst naar een yml bestand.

```yaml
beats_config_file: files/servers.yml
```
