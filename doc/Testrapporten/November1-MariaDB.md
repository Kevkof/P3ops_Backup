# Testrapport : November 1

- [x] Opstarten slaagt en start op zonder errors.
- [x] Testscript van de database geeft geen fouten
- [x] Echo1 en Mike1 kunnen verbinden met de database

Uitvoerder(s) testplan: Robin Roelandt

Uitgevoerd op 23/11/2017

## Test 1: Opzetten VM's

- Uitvoer:

```
==> november1: PLAY RECAP *********************************************************************
==> november1: november1                  : ok=54   changed=28   unreachable=0    failed=0
```


- Uitvoer:

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
       valid_lft 84387sec preferred_lft 84387sec
    inet6 fe80::af42:a0f6:c3bb:7058/64 scope link
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 08:00:27:6b:39:b0 brd ff:ff:ff:ff:ff:ff
    inet 172.16.128.7/24 brd 172.16.128.255 scope global enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe6b:39b0/64 scope link
       valid_lft forever preferred_lft forever
```

## Test 2: Uitvoeren testscript november1

- Uitvoer:
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
