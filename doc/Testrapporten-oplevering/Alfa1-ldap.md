# Testplan : LDAP

**Auteur(s) testplan**: David Gooskens

### Checklist

- [x] Opstarten slaagt zonder errors
- [x] IP-adressering komt overeen met de documentatie
- [x] Firewall: poort is opengezet
- [x] Afdelingen zijn aangemaakt
- [x] Elke afdeling bevat een gebruiker
- [x] Minstens 5 gebruikers zijn aangemaakt


## Test 2: Ip-addressing

Het ip address staat goed in de machine maar het oude(foute) ip address staat nog in het testplan. 

## Test 3: Firewall

- Voer op het hostsysteem `vagrant ssh alfa1` uit.
- Controleer of poort `389/tcp` open staat met `sudo firewall-cmd --list-all`. Verwachte uitvoer:
  ```
  public (active)
    target: default
    icmp-block-inversion: no
    interfaces: enp0s3 enp0s8
    sources:
    services: ssh dhcpv6-client
    ports: 389/tcp
    protocols:
    masquerade: no
    forward-ports:
    source-ports:
    icmp-blocks:
    rich rules:
  ```

- Niet zo correct: Er worden meer poorten toegelaten dan mogen eigenlijk dit komt door de samba groep die connectie probeerde te leggen met ldap. Dit zorgt niet voor problemen maar is wel onveilig.
opplossing is gewoonweg alle poorten in deze code weg doen buiten poort 389/tcp .
  ```
rhbase_firewall_allow_ports:
  - 389/tcp
  - 9830/tcp
  - 636/tcp
  - 3269/tcp:
    ```
	de foute output:
  ```
  public (active)
    target: default
    icmp-block-inversion: no
    interfaces: enp0s3 enp0s8
    sources:
    services: ssh dhcpv6-client
    ports: 389/tcp, 9830/tcp, 636/tcp, 3269/tcp
    protocols:
    masquerade: no
    forward-ports:
    source-ports:
    icmp-blocks:
    rich rules:
  ```
  
## Testinfo

Uitvoerder(s) test: David Gooskens
Uitgevoerd op: 18/12/2017


