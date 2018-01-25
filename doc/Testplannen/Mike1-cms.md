# Testplan : CMS Mike1

- [ ] Opstarten slaagt zonder errors.
- [ ] Testscript van delta1 geeft geen fouten.

Auteur(s) testplan: Florian Van Steen

## Test 1 - Opzetten VM's
1. Ga vanop de host-machine naar de map waar de vagrantfile zich bevind.
2. Typ het commando `vagrant status` in
3. Mike1 staat als `not created` in de lijst
   - Als mike1delta1 als `created` staat typ dan `vagrant destroy mike1` in.
4. Start Mike1 op met het commando `vagrant up mike1`
5. Ip configuratie checken met 'ip a'

**Verwachte resultaten**

- mike1 staat in de lijst van vm's.
- Verwacht resultaat na het opstarten van de vm:

```
==> mike1: PLAY RECAP *********************************************************************
==> mike1: mike1                      : ok=70   changed=39   unreachable=0    failed=0
==> mike1: + set +x
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
    inet 172.16.128.4/24 brd 172.16.128.255 scope global enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fece:b522/64 scope link
       valid_lft forever preferred_lft forever
```

## Test 2 - Uitvoeren testscript mike1
**Let op! November1 moet aanstaan en actief zijn om mike1 volledig te kunnen testen en het volledige testscript te laten slagen.**

1. Log in op mike1 met `vagrant ssh mike1`
2. Voer het testscript uit met het volgende commando: `sudo /vagrant/test/runbats.sh`
3. In dit testscript worden volgende tests overlopen:
   - De nodige packages zijn geinstalleerd
   - De Apache service werkt en is actief
   - De Apache service start op bij het booten van de VM
   - SELinux staat op 'enforcing'
   - De firewall blokkeert web traffic niet
   - De firewall laat de poort 389/tcp toe
   - De website is bereikbaar via het juist ip adres
   - De wordpress pagina is zichtbaar
      - Als deze test faalt dan heeft mike1 geen connectie met November1

**Verwachte resultaten**

```
$ sudo /vagrant/tests/runbats.sh

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

## Test 3 - Controleer of de wordpress bereikbaar is

1. Ga naar https://172.16.128.6/wp-admin/install.php op jouw host systeem
2. De welkompagina van wordpress is zichtbaar
