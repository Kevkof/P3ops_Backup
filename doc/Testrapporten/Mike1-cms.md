# Testrapport: Mike1 CMS

- [ ] Opstarten slaagt zonder errors.
- [ ] Testscript van delta1 geeft geen fouten.

Uitvoerder(s) test: Jolan Van Impe
Laatst uitgevoerd op: 17/12/2017

## Test 1 - Opzetten VM's

Uitvoer (opzetten mike1):

```
...
==> mike1: PLAY RECAP *********************************************************************
==> mike1: mike1                      : ok=70   changed=39   unreachable=0    failed=0
==> mike1: + set +x
```
Opzetten van Mike 1 is gelukt

uitvoer van command ip a
```
...
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP
qlen 1000
    link/ether 08:00:27:96:27:00 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 84792sec preferred_lft 84792sec
    inet6 fe80::a259:678c:2517:956/64 scope link
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP
qlen 1000
    link/ether 08:00:27:b9:7e:fc brd ff:ff:ff:ff:ff:ff
    inet 172.16.128.6/24 brd 172.16.128.255 scope global enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:feb9:7efc/64 scope link
       valid_lft forever preferred_lft forever
```
is gelukt


## Test 2 - Uitvoeren testscript mike1

Uitvoer van het testscript voor mike1:

```
...
Running test /vagrant/tests/mike1/mike1.bats
 ✓ The necessary packages should be installed
 ✓ The Apache service should be running
 ✓ The Apache service should be started at boot
 ✓ The SELinux status should be ‘enforcing’
 ✓ Web traffic should pass through the firewall
 ✓ Check if the firewall is allowing port 389/tcp
 ✓ The website should be accessible through HTTP at the right ip address
 ✓ The Wordpress install page should be visible under http://172.16.128.6/wordpress/

8 tests, 0 failures
```
-Alle test zijn geslaagd

## Test 3 - Controleer of de wordpress bereikbaar is

- Kan pagina bekijken via https://172.16.128.6/wp-admin/install.php
