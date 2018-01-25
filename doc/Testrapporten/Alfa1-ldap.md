# Testplan : LDAP

**Auteur(s) testplan**: Brecht Claeys

### Checklist

- [x] Opstarten slaagt zonder errors
- [x] IP-adressering komt overeen met de documentatie
- [ ] Firewall: poort is opengezet
- [x] Afdelingen zijn aangemaakt
- [x] Elke afdeling bevat een gebruiker
- [x] Minstens 5 gebruikers zijn aangemaakt


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

- Niet correct: enp0s8 wordt bij test niet toegelaten. Uitvoer:
  ```
  public (active)
    target: default
    icmp-block-inversion: no
    interfaces: enp0s3
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
  
## Testinfo

Uitvoerder(s) test: Brecht Claeys
Uitgevoerd op: 30/10/2017



# Tweede test

### Checklist

- [x] Opstarten slaagt zonder errors
- [x] IP-adressering komt overeen met de documentatie
- [x] Firewall: poort is opengezet
- [x] Afdelingen zijn aangemaakt
- [x] Elke afdeling bevat een gebruiker
- [x] Minstens 5 gebruikers zijn aangemaakt

## Testinfo

Uitvoerder(s) test: Brecht Claeys
Uitgevoerd op: 30/10/2017

# Derde test na wijzigingen LDAP

### Checklist

- [x] Opstarten slaagt zonder errors
- [x] IP-adressering komt overeen met de documentatie
- [x] Firewall: poort is opengezet
- [x] Afdelingen zijn aangemaakt
- [x] Elke afdeling bevat een gebruiker
- [x] Minstens 5 gebruikers zijn aangemaakt

## Testinfo

Uitvoerder(s) test: Brecht Claeys
Uitgevoerd op: 05/11/2017