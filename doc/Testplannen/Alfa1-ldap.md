# Testplan : alfa1 LDAP

**Auteur(s) testplan**: Lander Van den Bulcke

### Checklist

- [ ] Opstarten slaagt zonder errors
- [ ] IP-adressering komt overeen met de documentatie
- [ ] Firewall: poort is opengezet
- [ ] Afdelingen zijn aangemaakt
- [ ] Elke afdeling bevat een gebruiker
- [ ] Minstens 5 gebruikers zijn aangemaakt

## Test 1: Opstarten

- Ga op de host-machine naar de directory van het project
- Voer `vagrant status` uit. Server `alfa1` moet de status `not created` hebben.
  - Als dit niet het geval is, voer `vagrant destroy -f alfa1` uit.
- Start de LDAP server met het commando `vagrant up alfa1`.
  - Verwacht resultaat, zonder errors:
    ```
    ...
    PLAY RECAP *********************************************************************
    alfa1                      : ok=38   changed=2    unreachable=0    failed=0
    ...
    ```

## Test 2: IP addressering

- Voer op het hostsysteem `vagrant ssh alfa1` uit.
- Controleer het IP-adres met `ip address`
  - Het IP-adres moet `172.16.128.130` zijn. Verwachte uitvoer:
    ```
    ...
    3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 08:00:27:89:b9:5a brd ff:ff:ff:ff:ff:ff
    inet 172.16.128.130/24 brd 172.16.128.255 scope global enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe89:b95a/64 scope link
       valid_lft forever preferred_lft forever
    ```

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

## Test 4: LDAP

- Voer op het hostsysteem `vagrant ssh alfa1` uit.
- Controleer of de gebruikers en groepen zijn aangemaakt met het testscript. Verwachte uitvoer:
  ```
  [vagrant@alfa1 ~]$ sudo /vagrant/tests/runbats.sh
  Running test /vagrant/tests/alfa1/ldap.bats
   ✓ De ldap client tools moeten geïnstalleerd zijn.
   ✓ Er verbonden worden met LDAP met user "admin" en wachtwoord "password".
   ✓ De gewenste users bevinden zich in de LDAP database.
   ✓ Het wachtwoord van alle users is "password"
   ✓ De gewenste groepen bevinden zich in de LDAP database.
   ✓ De groepen bevatten minstens 1 gebruiker.

  6 tests, 0 failures
  ```
