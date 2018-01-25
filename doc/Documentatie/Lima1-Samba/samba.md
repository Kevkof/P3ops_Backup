# Documentatie Samba

**Opstellers van documentatie: David Gooskens, Ruben Bruggeman**

## Inleidende informatie

Samba is een fileserver die de functionaliteit heeft om documenten bij te houden en te distribueren naar de users die gebruik van maken van deze server.

Het was eigenlijk de bedoeling dat we een connectie legde met ldap (alfa1) maar hier zijn we niet in geslaagd, vandaar dat we zijn overgeschakeld naar een SAMBA standalone server.
De connectie met LDAP word wel nog altijd gedocumenteerd en staat in commentaar in de yml file.


## Server gegevens

- Namen: Lima1
- IP-adressen:
  - Lima: 172.16.128.5
- Service: Samba
- VLAN: 30
- Verantwoordelijkheid: `Groep 1`

## Gebruikte rollen

- [bertvv.rh-base](https://github.com/bertvv/ansible-role-rh-base)
- Samba (rol gebasseerd op bertvv.samba (https://github.com/bertvv/ansible-role-samba))

## Uitleg gebruikte variabelen

Er zijn enkele variabelen gedefinieerd in `ansible/host_vars/lima1.yml`. Hieronder verklaren we wat deze doen:

**Onderstaande variabele zorgt ervoor dat de juiste services worden toegelaten op de firewall. Samba-client bleek niet nodig te zijn bij de stand alone versie:**
```yaml
rhbase_firewall_allow_services:
   - samba
 # - samba-client
```

**Definiëren van een naam voor de groep die alle SAMBA shares omvat:**
```yaml
samba_workgroup: green.local
```

**Instellen van een comment string:**
```yaml
samba_server_string: 'Welcome to the green samba server'
```

**Instellen van de SAMBA security setting op user access:**
```yaml
samba_security: user
```

**Instellen dat de home directories van de SAMBA users beschikbaar zijn:**
```yaml
samba_load_homes: true
```

**Map en bestand definiëren, met een maximum grootte van 60000 bytes, waar exec informatie in terecht komt over de SAMBA service:**
```yaml
samba_log: /var/log/samba.log
samba_log_size: 60000
```

**symlinks creatie toestaan in /var/www/html bestand dat beschikbaar is voor elke share:**
```yaml
samba_create_varwww_symlinks: true
```


## Gebruikte variabelen voor SAMBA als standalone server

**De rhbase_user_groups worden aangemaakt en gedefiniëerd. Deze zijn nodig om later de rhbase_users en samba_users aan toe te kennen:**

```yaml
rhbase_user_groups:
  - itadministratie
  - verkoop
  - administratie
  - ontwikkeling
  - directie
  ```

**Maak 5 rhbase gebruikers aan. De namen van de gebruikers zijn hier willekeurig gekozen, de opgave vermeldt enkel dat er minstens vijf moeten zijn. De verschillende velden in de gebruiker-definitie zijn:**

| Veld        | Omschrijving                                                                |
| :---        | :---                                                                        |
| `name`      | De naam van de user.                                                        |
| `comment`   | Een beschrijving voor de user.                                              |
| `groups`    | De rhbase user groep(en) waartoe de user behoort                            |

```yaml
rhbase_users:
  - name: lander
    comment: 'Lander Van den Bulcke'
    groups:
      - itadministratie

  - name: torvalds
    comment: 'Linus Torvalds'
    groups:
      - verkoop

  - name: rms
    comment: 'Richard Stallman'
    groups:
     - administratie

  - name: knuth
    comment: 'Donald Knuth'
    groups:
     - ontwikkeling

  - name: dmr
    comment: 'Dennis Ritchie'
    groups:
     - directie
```

**Maak 5 SAMBA gebruikers aan. De namen van de gebruikers zijn hier willekeurig gekozen, de opgave vermeldt enkel dat er minstens vijf moeten zijn. De verschillende velden in de gebruiker-definitie zijn:**

| Veld         | Omschrijving                                                                |
| :---         | :---                                                                        |
| `name`       | De naam van de SAMBA user.                                                  |
| `password`   | Een wachtwoord voor de SAMBA user.                                          |
| `group`      | Bepalen tot welke rhbase user groep(en) de SAMBA user behoort.              |

```yaml
samba_users:
  - name: lander
    password: "password"
    group: itadministratie

  - name: torvalds
    password: "password"
    group: verkoop

  - name: rms
    password: "password"
    group: administratie

  - name: knuth
    password: "password"
    group: ontwikkeling

  - name: dmr
    password: "password"
    group: directie
```

**Maak 5 SAMBA shares aan. De verschillende velden in de definitie zijn:**

| Veld         | Omschrijving                                                                       |
| :---         | :---                                                                               |
| `name`       | De naam van de SAMBA share.                                                        |
| `group`      | Bepalen welke rhbase user groep(en) er toegang hebben tot de SAMBA share.          |
| `white_list` | Een lijst van rhbase user groepen die schrijfrechten hebben binnen de SAMBA share. |

```yaml
samba_shares:
   - name: itadministratie
     group: itadministratie
     write_list: +itadministratie     

   - name: verkoop
     group: verkoop
     write_list: +verkoop

   - name: administratie
     group: administratie
     write_list: +administratie

   - name: ontwikkeling
     group: ontwikkeling
     write_list: +ontwikkeling

   - name: directie
     group: directie
     write_list: +directie
```


## Gebruikte variabelen voor SAMBA server met LDAP configuratie


```yaml
#samba_passdb_backend: ldapsam:ldap://alfa1.green.local
of
#samba_passdb_backend: ldapsam:ldap://172.16.128.132
```

Deze variabelen zorgt er voor dat samba gaat zoeken naar ldap. Let op hier hebben we de niet secure versie gebruikt om met ldap contact te leggen als je de secure versie wilt gebruiken moet je een s hangen aan ldap.

```yaml
# samba_rootdn: "cn=admin"
```
Deze variable definieerd de Distinguished Name (DN) en word gebruikt door samba om ldap aan te spreken wanneer gebruikers informatie op te halen.

```yaml
# samba_suffix: "dc=green,dc=local"
```
Specifieerd de basis van alle ldap suffixen. In andere woorden als deze variable samba_user_suffix, samba_machine_suffix of  samba_group_suffix niet worden ingevuld zullen ze worden ingevuld met wat er in deze variable staat.



```yaml
# samba_user_suffix: "ou=People"
```
Deze variable specifieerd waar gebruikers in de "tree" worden gestoken. Zie ldap documentatie om te zien wat de tree is.


```yaml
# samba_machine_suffix: "ou=Computers"
```
Deze variable specifieerd waar machines in de "tree" worden gestoken. Zie ldap documentatie om te zien wat de tree is.

```yaml
# samba_group_suffix: "ou=Groups"
```
Deze variable specifieerd de suffix wanneer deze worden toegevoegd bij de ldap directory.


```yaml
# samba_local_master: false
```
Deze variable staat normaal op true maar moet op false staan anders zal nmbd proberen local master van het subnet te worden.


```yaml
# samba_ssl: "off"
```
Deze variable staat normaal gezien al default op off maar zorgde raar genoeg toch nog voor problemen. Als het op true staat dan zal samba SSL proberen te gebruiken wanneer hij met ldap wilt connecteren dit is problematisch als aan de ldap kant ssl niet goed geconfigureerd is dus zet je deze beter af.

```yaml
# samba_sync: "yes"
```
Deze variable syncroniseerd de ldap passwoorden met de NT en LM hashes voor normale accounts.

```yaml
# samba_hosts_allow: 172.16.128.132
```
Deze variable laat hoststoe om aan services te komen.

```yaml
#tasks:
#  - script: ../scripts/Lima/Lima.sh
```

Dit is eigenlijk een script die deze code uitvoerde:
[
sudo smbpasswd -w password
]
Het zorgde ervoor dat de admin van samba_rootdn het juiste wachtwoord kreeg om te kunnen connecteren met ldap.
