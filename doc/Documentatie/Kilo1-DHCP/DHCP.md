# Documentatie DHCP

## Server gegevens

- Naam: `kilo1`
- IP-adres: `172.16.128.4`
- Service: `DHCP`
- VLAN: `30`
- Alias: `dhcp`
- Verantwoordelijkheid: `Groep 2`

## Gebruike rollen

- [bertvv.dhcp](https://galaxy.ansible.com/bertvv/dhcp/)

## Uitleg gebruikte variabelen

Er zijn enkele variabelen gedefinieerd in `ansible/host_vars/kilo1.yml`. Hieronder verklaren we wat deze doen:

- Onderstaande variabelen stellen de **default lease time** en de **maximale lease time** in seconden.

  ```yaml
  dhcp_global_default_lease_time: 28800
  dhcp_global_max_lease_time: 43200
  ```
- De volgende variabele stelt de **domeinnaam** in.

  ```yaml
  dhcp_global_domain_name: green.local
  ```

- Verwijzen naar andere servers in het domein. De eerst variabele, _'dhcp_global_domain_name_servers'_, bevat een **opsomming van de DNS-servers** van het domein, zijnde bravo1 en charlie1.
- _'dhcp_global_routers'_ verwijst naar de default-gateway, de **router van VLAN 30**.

  ```yaml
  dhcp_global_domain_name_servers:
    - 172.16.128.133
    - 172.16.128.134
  dhcp_global_routers: 172.16.128.1  
  ```

- Aanmaken van het **subnet** gebeurd met de optie _'dhcp_subnets'_.
- Hieronder komen alle instelling die van toepassing zijn voor dit subnet.
- De DHCP server deelt alle IP-adressen met IP-adres 172.16.X.X. uit.
  - dynamisch uitgedeeld van `172.16.0.100` tot `172.16.127.254`
  - Dit wordt ingesteld met de opties _'range_begin'_ en _'range_end'_.
- Voor PXE-boot server worden variabelen booting, bootp and filename gebruikt.
- daarna maken we nog een 2de subnet maar dit is een leeg **/25 subnet** voor Ip-adressen met de vorm van `172.16.X.X`. 

  ```yaml
  dhcp_subnets:
    - ip: 172.16.0.0
      netmask: 255.255.0.0     
      range_begin: 172.16.0.100           
      range_end: 172.16.127.254           
      booting: allow
      bootp: allow
      filename: pxelinux/pxelinux.0
    - ip: 172.16.128.0
      netmask: 255.255.255.128
  ```


- Verwijzen naar de pxeBoot server in het domein, hiervoor staat de variable `dhcp_global_next_server` in. Je geeft het ip addres van de server mee als parameter.

  ```yaml
        dhcp_global_next_server: 172.16.128.9
  ```

- Sommige hosts krijgen een IP-adres op basis van hun MAC-adres. We hebben beslist om de range voor deze soort hosts begint van `172.16.0.11` tot `172.16.0.15`
- De variabelen zelf spreken voor zich. De naam om de host te identificeren, het MAC-adres en bijhorend vast IP-adres.

  ```yaml
  dhcp_hosts:
    - name: workstation1                      
      mac: '00:23:ae:b0:8e:29'
      ip: 172.16.0.11
   ```
---
