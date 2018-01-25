# Testrapport Echo1

Checklist

- [x] Opstarten slaagt en start op zonder errors.
- [x] IP-adressing komt overeen met documentatie IP-adressing.
- [x] Testpagina webserver zichtbaar
- [x] Drupalpagina zichtbaar

Uitvoerder(s) test: Stijn De Lannoy
Uitgevoerd op: 20/11/2017

## Test 1 - Opzetten VM:

Het opzetten van de vm via het commando 'vagrant up echo1' verloopt zonder fouten.

- Uitvoer
```
[vagrant@echo1 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 08:00:27:96:27:00 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 86030sec preferred_lft 86030sec
    inet6 fe80::15b6:5a62:e64b:fb0c/64 scope link
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 08:00:27:31:68:24 brd ff:ff:ff:ff:ff:ff
    inet 172.16.128.136/24 brd 172.16.128.255 scope global enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe31:6824/64 scope link
       valid_lft forever preferred_lft forever
```

## Test 2 - Uitvoeren testscript webserver_drupal

 Dit kan uitgevoerd worden met het commando 'sudo /vagrant/tests/runbats.sh'.
 Dit script verloot zonder fouten.

 - uitvoer
```
[vagrant@echo1 ~]$ sudo /vagrant/tests/runbats.sh
  Running test /vagrant/tests/echo1/webserver_drupal.bats
   ✓ De nodige packages zijn geinstalleerd
   ✓ De Apache service werkt
   ✓ De Apache service start op bij boot
   ✓ De firewall laat webservices door
   ✓ De drupal database name is juist geconfigureerd
   ✓ De drupal database username is juist geconfigureerd
   ✓ De drupal database password is juist geconfigureerd
   ✓ De drupal database host ip is juist geconfigureerd
   ✓ Je kan de website bezoeken via http
   ✓ je kan de website bezoeken via https
   ✓ Je hebt connectie met de databank
   ✓ Je hebt connectie met de databank


  12 tests, 0 failures

```


## Test 3 - Controleren of website te bekijken is via host systeem.
De drupal site kan bekeken worden door het adres http://172.16.128.136/drupal7/install.php in te geven.

