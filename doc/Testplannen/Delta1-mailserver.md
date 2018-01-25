# Testplan : Delta1

- [ ] Opstarten slaagt zonder errors.
- [ ] Testscript van mailserver geeft geen fouten.
- [ ] Zonder problemen mail sturen vanuit mailclient vanop workstation
- [ ] Zonder problemen mail sturen vanuit squirrelmail

Auteur(s) testplan: Pieter-Jan Philips en Robbe Devos

## Test 1 - Opzetten VM's
1. Ga vanop de host-machine naar de map waar de vagrantfile zich bevind.
2. Typ het commando `vagrant status` in
3. Delta1 staat als `not created` in de lijst
   - Als delta1 als `created` staat typ dan `vagrant destroy delta1` in.
4. Start delta1 op met het commando `vagrant up delta1`
5. Ip configuratie checken met 'ip a'

**Verwachte resultaten**

- Delta1 staat in de lijst van vm's.
- Verwacht resultaat na het opstarten van de vm:

```
PLAY RECAP *********************************************************************
delta1                     : ok=95   changed=54   unreachable=0    failed=0
```

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
1. Log in op de echo1 server met het commando `vagrant ssh delta1`
2. Voer het testscript uit met het commando `Sudo /vagrant/test/runbats.sh`
3. Het testscript zal de volgende zaken testen:
    - The necessary packages should be installed
    - The Postfix service should be running
    - The Dovecot service should be running
    - The SELinux status should be ‘enforcing’
    - Web and mail traffic should pass through the firewall
    - The users robbe and robin should exists
    - The website should be accessible through HTTP at the right ip address
    - The squirrelmail page should be visible under http://172.16.128.135/

**verwacht resultaat:**

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

1. Zorg ervoor dat je een workstation hebt op het netwerk.
2. Ping naar `172.16.128.135` vanop jouw workstation
3. Open jouw mail client naar keuze
4. Voeg een nieuw account toe en geef de volgende instellingen in
    - Naam : `robbe`
    - email : `robbe@green.local`
    - Server IMAP name : `mail.green.local`
    - Server IMAP port : `143`
    - Server IMAP Authentication : `TLS`
    - Server IMAP username: `robbe`
    - Server SMTP name: `mail.green.local`
    - Server SMTP port: `25`
5. Wanneer de server vraagt naar een Wachtwoord vul `robbe` in.
6. De server vraagt om certificaten te vertrouwen, Accepteer de certificaten
7. Voeg een tweede nieuwe account toe en geef de volgende instellingen in :
    - Naam : `robin`
    - email : `robin@green.local`
    - Server IMAP name : `mail.green.local`
    - Server IMAP port : `143`
    - Server IMAP username: `robin`
    - Server SMTP name: `mail.green.local`
    - Server SMTP port: `25`
8. Wanneer de server vraagt naar een Wachtwoord vul `robin` in.
9. De server vraagt om certificaten te vertrouwen, Accepteer de certificaten
10. Stuur een mail vanop het account robbe naar `robin@green.local`
11. Stuur een mail vanop het account robin naar `robbe@green.local`

**Verwachte resultaten**

- Je kan pingen naar 172.16.128.135
- Je kan zonder problemen account robbe toevoegen
- Je kan zonder problemen account robin toevoegen
- De mail van account robin komt aan op het account van robbe
- de mail van account robbe komt aan op het account van robin

## Test 4 - Mail sturen vanuit squirrelmail

1. Surft naar `http://172.16.128.135/squirrelmail/`
2. Log aan met: username `robbe` | password  `robbe`
3. Stuur een mail naar robin@green.local
4. Log out
5. Log aan met: username `robin` | password `robin`
6. Bekijk postvak in

**Verwachten resultaten**
- Je kan zonder problemen aanmelden als robbe
- Je kan zonder problemen aanpalen als robin
- Je ziet de mail op het account van robin die je gestuurd hebt vanuit account robbe
