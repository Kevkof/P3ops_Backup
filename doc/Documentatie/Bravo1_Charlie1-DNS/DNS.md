# Documentatie DNS

## Server gegevens
- Namen: Bravo1, Charlie1
- IP-adressen:
  - Bravo1: 172.16.128.133
  - Charlie1: 172.16.128.134
- Service: DNS(master/slave)
- VLAN: 50
- Alias:
  - Bravo1:ns1
  - Charlie1: ns2
- Verantwoordelijkheid: `Groep 2`

## Gebruikte rollen

- https://galaxy.ansible.com/bertvv/bind/
- https://galaxy.ansible.com/bertvv/rh-base/

## Uitleg gebruikte variabelen

Er zijn enkele variabelen gedefinieerd in zowel `ansible/host_vars/bravo1.yml` als `ansible/host_vars/charlie1.yml`. Hieronder verklaren we wat deze doen:


* Onderstaande variabele zorgt ervoor dat de juiste poort wordt opengezet op de firewall:
  ```yaml
  rhbase_firewall_allow_services:
    - dns
  ```


* Onderstaande variabele maakt een ACL die IP-adressen van de vorm 172.16.128.X met subnetmask 255.255.255.0 doorlaat (CIDR-notatie /24)

  ```yaml
  bind_acls:
    - name: acl1
      match_list:
        - 172.16.128/24

  ```

* Onderstaande variabelen stellen de naam van de zone en het ip-adres van de master DNS in het config bestand `named.conf`

  ```yaml
  bind_zone_name: 'green.local'
  bind_zone_master_server_ip: 172.16.128.133

  ```

* Onderstaande variabele stelt het netwerk in waarin de DNS IP-adressen resolved

  ```yaml
  bind_zone_networks:
    - '172.16.128'

  ```


* Onderstaande variabele stelt de DNS servers in die bekend staan binnen het domein

  ```yaml
  bind_zone_name_servers:
    - bravo1
    - charlie1

  ```

* Onderstaande variabele stelt elke hostnaam met zijn bijhorend IP-adres in en eventueel ook zijn alias. __Dit is enkel voor de Master-DNS (charlie kopieert dit van bravo1)__

  ```yaml
  bind_zone_hosts:
  - name: bravo1
    ip: 172.16.128.133
    aliases:
      - ns1
  - name: charlie1
    ip: 172.16.128.134
    aliases:
      - ns2
  - name: alfa1
    ip: 172.16.128.132
    aliases:
      - ad
  - name: delta1
    ip: 172.16.128.135
    aliases:
      - mail
  - name: echo1
    ip: 172.16.128.136
    aliases:
      - www
  - name: kilo1
    ip: 172.16.128.4
    aliases:
      - dhcp
  - name: lima1
    ip: 172.16.128.5
    aliases:
      - files
  - name: mike1
    ip: 172.16.128.6
    aliases:
      - cms
  - name: november1
    ip: 172.16.128.7
    aliases:
      - db
  - name: oscar1
    ip: 172.16.128.8
    aliases:
      - mon
  - name: papa1
    ip: 172.16.128.9
    aliases:
      - pxe
  - name: quebec1
    ip: 172.16.128.10
    aliases:
      - dnsfwd
  - name: virt1
    ip: 172.16.128.130
  - name: virt2
    ip: 172.16.128.131
  - name: virt3
    ip: 172.16.128.2
  - name: virt4
    ip: 172.16.128.3

  ```
* Met onderstaande instellingen stellen we de mailservers voor green.local op de DNS servers.
  ```yaml
  bind_zone_mail_servers:
    - name: delta1
      preference: 10
  ```

* Onderstaande variable zorgt dat querries toegelaten worden door elk IP-adres

```yaml
bind_allow_query:
  - any
bind_listen_ipv4:
  - any
```
