# Testplan : oscar1 Monitoring-server

**Opsteller testplan:** Matti De Grauwe & Brecht Claeys

Dit testplan zal de werking de monitoring-server testen, zijnde 'oscar1'.

Checklist

- [ ] Opstarten slaagt en start op zonder errors.
- [ ] IP-adressing komt overeen met documentatie IP-adressing.
- [ ] Kibana werkt
- [ ] Elasticsearch index werkt

## Test 1 - Opzetten VM's:

1. Ga vanop de host-machine naar de lokale working directory van het project.
2. Voer het volgende commando uit: `vagrant status`

    - Er zou vervolgens een lijst van virtuele machines moeten getoond worden. Daar zou 'oscar1' de status `not created` moeten hebben. Indien dit niet het geval is, voer het commando `vagrant destroy -f oscar1`
3. Start vervolgens de monitoring-servers op met het commando `vagrant up oscar1`. (Nodig roles dienen geïnstalleerd te zijn)
    - Verwacht resultaat is dat dit uitvoert zonder errors.
      ```
      PLAY RECAP *************************************************
      bravo1      : ok=22   changed=16   unreachable=0    failed=0
      ```

 ## Test 2 - Controle IP-adressering:  

1. Typ op het hostsysteem het commando `vagrant ssh oscar1`
2. Geef het commando 'ip a' in
3. Het scherm toont volgend uitvoer:

    ```
      1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
      2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 08:00:27:96:27:00 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 85691sec preferred_lft 85691sec
    inet6 fe80::cffb:9b16:c3e2:60a/64 scope link
       valid_lft forever preferred_lft forever
      3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 08:00:27:9d:10:ed brd ff:ff:ff:ff:ff:ff
    inet 172.16.128.6/24 brd 172.16.128.255 scope global enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe9d:10ed/64 scope link
       valid_lft forever preferred_lft forever
    ```
4.  Controleer of de IP-adressing in dit commando overeenkomt met [documentatie](https://github.com/HoGentTIN/p3ops-green/blob/master/doc/ip-subnetting.md) van het project die de adrestabel toont.

## Test 3 - Kibana check:  

1. Surf in je browser naar het IP 172.16.128.6:5601, je zou kibana moeten zien.
2. Bij status zou je de succesvolle configuratie moeten zien

## Test 4 - Elasticsearch check:

1. Druk op het tabblad "status" van Kibana op IP 172.16.128.6:5601
2. De elasticsearch index zou ready moeten zijn.

![status kibana](https://i.imgur.com/z30lfjT.png)
