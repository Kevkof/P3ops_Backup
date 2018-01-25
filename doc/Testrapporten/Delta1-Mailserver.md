# Testrapport Delta1

Checklist
- [x] Opstarten slaagt zonder errors.
- [x] Testscript van mailserver geeft geen fouten.
- [x] Zonder problemen mail sturen vanuit mailclient vanop workstation
- [x] Zonder problemen mail sturen vanuit squirrelmail

Auteur(s) testrapport: Robbe Devos en Stijn De Lannoy

Uitgevoerd op: 11/12/2017

## Test 1 - Opzetten VM:

- Het opzetten van de vm via het commando 'vagrant up delta1' verloopt zonder fouten.
```
PLAY RECAP *********************************************************************
delta1                     : ok=95   changed=54   unreachable=0    failed=0
```

- Uitvoer van ip a klopt volledig
```
[vagrant@delta1 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 08:00:27:96:27:00 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 86171sec preferred_lft 86171sec
    inet6 fe80::f2cd:ad11:4f60:e4a2/64 scope link
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 08:00:27:ce:b5:22 brd ff:ff:ff:ff:ff:ff
    inet 172.16.128.135/16 brd 172.16.255.255 scope global enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fece:b522/64 scope link
       valid_lft forever preferred_lft forever
```

## Test 2 - Uitvoeren testscript delta1
- Script kan uitgevoerd worden zonder problemen
- Alles testen in het script zijn geslaagd

```
Running test /vagrant/tests/delta1/mailserver.bats
 ✓ The necessary packages should be installed
 ✓ The Postfix service should be running
 ✓ The Dovecot service should be running
 ✓ The SELinux status should be ‘enforcing’
 ✓ Web and mail traffic should pass through the firewall
 ✓ The users robbe and robin should exists
 ✓ The website should be accessible through HTTP at the right ip address
 ✓ The squirrelmail page should be visible under http://172.16.128.135/squirrelmail/

8 tests, 0 failures
```

## Test 3 - Mail sturen vanuit mailclient

- Ik kan pingen vanop het workstation naar `172.16.128.135`
- Ik kan de account robbe en robin toevoegen aan de mailclient
- De mail vanuit robbe komt aan bij robin
- de mail vanuit robin komt aan bij robbe


## Test 4 - Mail sturen vanuit squirrelmail

- Ik kan aanmelden als robbe
- ik kan mij aanmelen als robin
- De mail die ik vanuit robbe heb gestuurd komt aan bij robin
