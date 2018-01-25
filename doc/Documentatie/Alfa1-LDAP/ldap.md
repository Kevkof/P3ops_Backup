# Documentatie LDAP

## Inleidende informatie

LDAP is in principe een soort database die gegevens over gebruikers opslaat in een boomstructuur. Queries op deze structuur vorm je als volgt:

- De wortel die wij gebruiken is `dc=green,dc=local`. Als je hierop zoekt krijg je alle items in de boom.
- Als je wil specifiëren kan dat door de naam van een kind vooraan de zoekstring toe te voegen. Bijvoorbeeld, de gebruikers zitten in de OU 'Users'. Als je dus enkel op gebruikers wilt zoeken, gebruik je de zoekstring `ou=Users,dc=green,dc=local`.
- Ook de gebruikers zelf zijn gewoon een blad in deze boom. Als je dus op één specifieke gebruiker wilt zoeken kan dat door zijn `uid` toe te voegen aan de zoekstring: `uid=lander,ou=Users,dc=green,dc=local`.
- Om deze queries handmatig uit te voeren kan je de tool `ldapsearch` gebruiken. Deze tool bevindt zich in de package `openldap-clients`. Gebruik bijvoorbeeld `ldapsearch -x -b "dc=green,dc=local" -D "cn=Admin" -w password`.

In bovenstaand commando wordt geauthenticeerd met `cn=Admin`. Dit is de admin account. Je kan echter ook verbinden met één van de andere gebruikers, bijvoorbeeld om het wachtwoord te testen. Als je bijvoorbeeld wil verbinden als de user `lander` kan je volgend commando gebruiken: `ldapsearch -x -b "dc=green,dc=local" -D "uid=lander,ou=Users,dc=green,dc=local" -w password`. 

## Gebruikte rollen

- [bertvv.rh-base](https://github.com/bertvv/ansible-role-rh-base)
- [CSCfi.389-ds](https://github.com/CSCfi/ansible-role-389-ds)
- 389-ds-config (eigen rol)

## Uitleg gebruikte variabelen

Er zijn enkele variabelen gedefinieerd in `ansible/host_vars/alfa1.yml`. Hieronder verklaren we wat deze doen:

```yaml
rhbase_firewall_allow_ports:
  - 389/tcp
```
Deze variabele zorgt ervoor dat de juiste poort wordt toegelaten op de firewall. LDAP draait op poort 389 (TCP), en dus laten we deze poort toe.

```yaml
dirsrv_fqdn: alfa1.green.local
dirsrv_password: password
dirsrv_rootdn: "cn=Admin"
```

Deze variabelen configureren de domeinnaam van de LDAP server en de Admin-account.

```yaml
dirsrv_remove_entries:
  - "ou=Special Users,dc=green,dc=local"
  - "cn=Accounting Managers,ou=Groups,dc=green,dc=local"
  - "cn=HR Managers,ou=Groups,dc=green,dc=local"
  - "cn=QA Managers,ou=Groups,dc=green,dc=local"
  - "cn=PD Managers,ou=Groups,dc=green,dc=local"
```

Verwijder de entries die standaard worden aangemaakt en die we niet nodig hebben.

```yaml
dirsrv_users:
  - uid: lander
    cn: Lander Van den Bulcke
    sn: Van den Bulcke
    description: Lander Van den Bulcke
    password: "{SSHA}AO50t57kJUiQYk3pnXh+yI23/2+2wgkg" # hash for "password"
    uidnumber: 700
    gidnumber: 700
    loginshell: /bin/bash
    homedirectory: /home/lander
  - uid: torvalds
    cn: Linus Torvalds
    sn: Torvalds
    description: Linus Torvalds
    password: "{SSHA}AO50t57kJUiQYk3pnXh+yI23/2+2wgkg" # hash for "password"
    uidnumber: 701
    gidnumber: 701
    loginshell: /bin/bash
    homedirectory: /home/torvalds
  - uid: rms
    cn: Richard Stallman
    sn: Stallman
    description: Richard Stallman
    password: "{SSHA}AO50t57kJUiQYk3pnXh+yI23/2+2wgkg" # hash for "password"
    uidnumber: 702
    gidnumber: 702
    loginshell: /bin/bash
    homedirectory: /home/rms
  - uid: knuth
    cn: Donald Knuth
    sn: Knuth
    description: Donald Knuth
    password: "{SSHA}AO50t57kJUiQYk3pnXh+yI23/2+2wgkg" # hash for "password"
    uidnumber: 703
    gidnumber: 703
    loginshell: /bin/bash
    homedirectory: /home/knuth
  - uid: dmr
    cn: Dennis Ritchie
    sn: Ritchie
    description: Dennis Ritchie
    password: "{SSHA}AO50t57kJUiQYk3pnXh+yI23/2+2wgkg" # hash for "password"
    uidnumber: 704
    gidnumber: 704
    loginshell: /bin/bash
    homedirectory: /home/dmrr
```

Maak 5 gebruikers aan. De namen van de gebruikers zijn hier willekeurig gekozen, de opgave vermeldt enkel dat er minstens vijf moeten zijn. De verschillende velden in de gebruiker-definitie zijn:

| Veld            | Omschrijving                                                                                                          |
| :---            | :---                                                                                                                  |
| `uid`           | De user-id (login) voor de gebruiker.                                                                                 |
| `cn`            | De 'common name'; de naam die door LDAP gebruikt wordt.                                                               |
| `sn`            | De 'surname'; de familienaam van de gebruiker dus.                                                                    |
| `description`   | Een beschrijving van de gebruiker                                                                                     |
| `password`      | Het paswoord van de gebruiker, in een hash. ([generator](http://projects.marsching.org/weave4j/util/genpassword.php)) |
| `uidnumber`     | Het user-id (getal) dat door Linux zal gebruikt worden.                                                               |
| `gidnumber`     | Het group-id (getal) dat door Linux zal gebruikt worden.                                                              |
| `loginshell`    | De standaard shell voor de gebruiker.                                                                                 |
| `homedirectory` | De locatie van de home-folder van de gebruiker.                                                                       |

```yaml
dirsrv_groups:
  - name: itadministratie
    gidnumber: 600
    members:
      - lander
  - name: verkoop
    gidnumber: 601
    members:
      - torvalds
  - name: administratie
    gidnumber: 602
    members:
      - rms
  - name: ontwikkeling
    gidnumber: 603
    members:
      - knuth
  - name: directie
    gidnumber: 604
    members:
      - dmr
```

Maak de 5 groepen aan en maak van elke groep een andere gebruiker lid. De verschillende velden in de groep-definitie zijn de volgende:

| Veld        | Omschrijving                                                                |
| :---        | :---                                                                        |
| `name`      | De naam van de groep.                                                       |
| `gidnumber` | Het group-id (getal) dat door Linux zal gebruikt worden.                    |
| `members`   | Een lijst van `uid`s van bestaande gebruikers die in de groep moeten komen. |

## Connectie gegevens

- RootDN: `cn=admin`
- RootDN password: `password`
- Suffix: `dc=green,dc=local`
- Gebruikers zijn te vinden onder `ou=People,dc=green,dc=local`
- Groepen zijn te vinden onder `ou=Groups,dc=green,dc=local`
