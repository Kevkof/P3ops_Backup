# Documentatie Mailserver

## Server gegevens

- Naam: `delta1`
- IP-adres: `172.16.128.135`
- Service: `Mailserver`
- VLAN: `50`
- Alias: `mail`
- Verantwoordelijkheid: `Team 5`

## Gebruike rollen

- [bertvv.mailserver](https://galaxy.ansible.com/bertvv/mailserver/)
- [bertvv.squirrlmail](https://galaxy.ansible.com/bertvv/squirrelmail/)
- [bertvv.httpd](https://galaxy.ansible.com/bertvv/squirrelmail/httpd)
- [geerlingguy.php](https://galaxy.ansible.com/geerlingguy/php/)

## Uitleg gebruikte variabelen

Er zijn enkele variabelen gedefinieerd in `ansible/host_vars/delta1.yml`. Hieronder verklaren we wat deze doen:

- Onderstaande variabele geeft aan welke **poorten** de firewall moet openzetten om de mailserver toegankelijk te maken van op het netwerk.

```yaml
rhbase_firewall_allow_services:
  - imap
  - imaps
  - pop3
  - pop3s
  - http
  - https
  - smtp
  - smtps
  - smtp-submission
```

- Onderstaande variabele geeft aan dat de **httpd scriptingtaal** php moet zijn.

```yaml
httpd_scripting: 'php'
```

- Onderstaande variabele maakt ons **2 gebruikers** aan die we kunnen gebruiken om de mailserver te testen.

```yaml
rhbase_users:
  - name: robbe
    password: '$6$9BUCNs4hpU86lhB5$DzCc9fWmTrAfGJ5yWCpe5ZeUQk9c/kzh6DZ3HJQDtv2OjOFJTjnwz7nwe/iEd0j5vo05csc7t3INYf7rBqUZy0'
    shell: /sbin/nologin

  - name: robin
    password: '$6$BVdU.mRWqhZzfPQx$7ESB7dLFqB3KvRaJ9Qj/5r3AFccaJ08S4KOIr.PwessZCRldN.TVbyWbN6XTn6r2Fj6aZa5IUQRxV1/uzVOt/.'
    shell: /sbin/nologin
```

- Onderstaande variabele zegt dat de postfix hostname mail.green.local moet zijn.

```yaml
postfix_myhostname: mail.green.local
```

- Onderstaande variabele zegt dat de postfix domainnaam green.local moet zijn.

```yaml
postfix_mydomain: green.local
```

- Onderstaande variabele stellen deze waarden ook in voor de squirrlmail frontend.

```yaml
Squirrelmail_domain: green.local
Squirrelmail_imapServerAddress: mail.green.local
Squirrelmail_smtpServerAddress: mail.green.local
```

- Onderstaande variabele zet de documentroot voor httpd.

```yaml
httpd_DocumentRoot: /var/www/
```

- Onderstaande variabele is voor de monitor services.

```yaml
beats_config_file: files/servers.yml
```



