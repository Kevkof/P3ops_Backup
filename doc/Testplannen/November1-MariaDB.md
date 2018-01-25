# Testplan : November1

- [ ] Opstarten slaagt zonder errors.
- [ ] Testscript van database werkt geeft geen failures.
- [ ] Echo1 en mike1 kunnen verbinden met de database.

Auteur(s) testplan: Stijn De Lannoy

## Test 1 - Opzetten VM's
1. Ga vanop de host-machine naar de map waar de vagrantfile zich bevind.
2. Typ het commando `vagrant status` in
3. November1 staat als `not created` in de lijst
   - Als november1 als `created `staat typ dan `vagrant destroy november1` in.
4. Start november1 op met het commando `vagrant up november1`
5. ip configuratie checken met `ip a`


**Verwachte resultaten**

- november1 staat in de lijst van vm's.
- verwacht resultaat na het opstarten van de vm.

  ```
    ==> november1: PLAY RECAP *********************************************************************
      ==> november1: november1                  : ok=54   changed=28   unreachable=0    failed=0
  ```
  
- ip configuratie moet er als volgt uitzien : 

```         
[vagrant@november1 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 08:00:27:96:27:00 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 84186sec preferred_lft 84186sec
    inet6 fe80::116e:95da:229a:f6d7/64 scope link
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 08:00:27:b7:9a:b9 brd ff:ff:ff:ff:ff:ff
    inet 172.16.128.7/24 brd 172.16.128.255 scope global enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:feb7:9ab9/64 scope link
       valid_lft forever preferred_lft forever
```

## Test 2 - Uitvoeren testscript november1
1. Log in op de echo1 server met het commando `vagrant ssh november1`
2. Voer het testscript uit met het commando `Sudo /vagrant/test/runbats.sh`
3. Het testscript zal de volgende zaken testen:
   - The MariaDB service should be running
   - The MariaDB service should be started at boot
   - The SELinux status should be ‘enforcing’
   - Mysql traffic should pass through the firewall
   - Mariadb should have a root user "november1" and password "november1"
   - Mariadb should have a DB "echo1DB"
   - Mariadb should have a DB "mike1DB"
   - The MariaDB root user (november1) user should have "write access" to the database

**Verwachten resultaten:**

```
  
        Running test /vagrant/tests/november1/november1.bats
        ✓ The MariaDB service should be running
        ✓ The MariaDB service should be started at boot
        ✓ The SELinux status should be ‘enforcing’
        ✓ Mysql traffic should pass through the firewall
        ✓ Mariadb should have a root user "november1" and password "november1"
        ✓ Mariadb should have a DB "echo1DB"
        ✓ Mariadb should have a DB "mike1DB"
        ✓ The MariaDB root user (november1) user should have "write access" to the database

        8 tests, 0 failures
```
