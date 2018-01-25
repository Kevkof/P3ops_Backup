# Testrapport : Monitoring-server

Checklist

- [x] Opstarten slaagt en start op zonder errors.
- [x] IP-adressing komt overeen met documentatie IP-adressing.
- [x] Kibana werkt
- [x] Elasticsearch index werkt

## Test 1 - Uitvoer playbook:

- Uitvoer:
  ```
  PLAY RECAP **************************************************
  oscar1       : ok=25   changed=19   unreachable=0    failed=0  
  ```

 ## Test 2 - Controle IP-adressering:  

- Uitvoer

    ```
    [vagrant@oscar1 ~]$ ip a
      1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
         link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
         inet 127.0.0.1/8 scope host lo
            valid_lft forever preferred_lft forever
         inet6 ::1/128 scope host
            valid_lft forever preferred_lft forever
      2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
         link/ether 08:00:27:96:27:00 brd ff:ff:ff:ff:ff:ff
         inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
            valid_lft 85911sec preferred_lft 85911sec
         inet6 fe80::ecc:cb4e:34ff:7c85/64 scope link
            valid_lft forever preferred_lft forever
      3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
         link/ether 08:00:27:9e:ed:ec brd ff:ff:ff:ff:ff:ff
         inet 172.16.128.6/24 brd 172.16.128.255 scope global enp0s8
            valid_lft forever preferred_lft forever
         inet6 fe80::a00:27ff:fe9e:edec/64 scope link
            valid_lft forever preferred_lft forever
    ```

## Test 3 - Kibana check:  

- Werkt op het IP-adres: 192.168.128.8

## Test 4 - Elasticsearch check:

- Uitvoer zoals verwacht:

  ![status kibana](https://i.imgur.com/pPgGUTB.png)

## Testinfo

Uitvoerder(s) testplan: Brecht Claeys
Uitgevoerd op: 18/12/2017
