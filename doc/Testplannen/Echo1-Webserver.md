# Testplan : Echo1 Webserver

- [ ] Opstarten slaagt zonder errors.
- [ ] Testscript van webserver met drupal heeft geen failures.
- [ ] Drupal website bereikbaar vanaf hostsysteem.

Auteur(s) testplan: Robbe Devos

## Test 1 - Opzetten VM's
1. Ga vanop de host-machine naar de map waar de vagrantfile zich bevind.
2. Typ het commando `vagrant status` in
3. Echo1 staat als `not created` in de lijst
   - Als echo1 als `created `staat typ dan `vagrant destroy echo1` in.
4. Start echo1 op met het commando `vagrant up echo1`.
5. Ip configuratie checken met 'ip a'

**Verwachte resultaten**
  - Echo1 staat in de lijst met VMs
  - Verwachte resultaat na het opstarten van vm's
    ```
    ==> echo1: PLAY RECAP *********************************************************************
    ==> echo1: echo1                      : ok=41   changed=26   unreachable=0    failed=0
    ```
- Verwachten resultaten uitvoer van ip a
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
*november1 moet aanstaan om echo1 volledig te testen,
Ga naar testplan/november1 om november 1 op te zetten en te testen.*
1. Log in op de echo1 server met het commando `vagrant ssh echo1`
2. Voer het testscript uit met het commando `Sudo /vagrant/test/runbats.sh`
3. Het testscript zal de volgende zaken testen:
    - De nodige packages zijn geinstalleerd
    - De Apache service werkt
    - De Apache service start op bij boot
    - De firewall laat webservices door
    - De drupal database name is juist geconfigureerd
    - De drupal database username is juist geconfigureerd
    - De drupal database password is juist geconfigureerd
    - De drupal database host ip is juist geconfigureerd
    - Je kan de website bezoeken via http
    - Je kan de website bezoeken via https
    - je hebt connectie met de databank
      - Wanneer de server november1 niet opstaat faalt deze test.

**verwachten resultaten**
1.Wanneer het script klaar is zou je de volgende resultaten moeten krijgen.
  ```
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
1. Ga naar `172.16.128.136/drupal7/install.php` op jouw host systeem.
2. Je zou nu de installatie pagina van durpal moetne zien.
