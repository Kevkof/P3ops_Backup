# Testplan : LDAP

**Auteur(s) testplan**: Lander Van den Bulcke

### Checklist

- [x] Opstarten slaagt zonder errors
- [x] IP-adressering komt overeen met de documentatie
- [x] Firewall: poort is opengezet
- [x] Afdelingen zijn aangemaakt
- [x] Elke afdeling bevat een gebruiker
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
- Gebruik `ldapsearch -x -b "dc=green,dc=local" -D "cn=Admin" -w password` om het volgende te controleren:
  - De volgende afdelingen zijn aangemaakt:
    - IT Administratie
    - Verkoop
    - Administratie
    - Ontwikkeling
    - Directie
    
    De output die hiervoor verwacht wordt is van volgende vorm:
    ```
    # itadministratie, Groups, green.local
    dn: cn=itadministratie,ou=Groups,dc=green,dc=local
    objectClass: top
    objectClass: posixGroup
    cn: itadministratie
    gidNumber: 600
    memberUid: lander
    ```
  - Er zit in elk van bovenstaande groepen minstens 1 gebruiker (vorm: `memberUid: lander`)
  - Er zijn minstens 5 gebruikers aangemaakt. De verwachte output hiervoor is van de vorm:
    ```
    # lander, People, green.local
    dn: uid=lander,ou=People,dc=green,dc=local
    cn: Lander Van den Bulcke
    sn: Van den Bulcke
    objectClass: top
    objectClass: person
    objectClass: posixAccount
    objectClass: shadowAccount
    uid: lander
    uidNumber: 700
    gidNumber: 700
    gecos: Lander Van den Bulcke
    loginShell: /bin/bash
    homeDirectory: /home/lander
    shadowLastChange: 17474
    userPassword:: e1NTSEF9QU81MHQ1N2tKVWlRWWszcG5YaCt5STIzLzIrMndna2c=
    ```

