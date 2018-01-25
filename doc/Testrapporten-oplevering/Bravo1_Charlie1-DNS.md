# Testrapport: DNS master en slave

- [x] Opstarten slaagt en start op zonder errors.
- [x] IP-adressing komt overeen met documentatie IP-adressing.
- [x] Zones op master zijn correct.
- [x] Replicatie heeft bestanden van master naar slave gekopieerd
- [x] Testscript van DNS-master heeft geen failures.
- [x] Testscript van DNS-slave heeft geen failures.
- [x] DNS bereikbaar vanaf hostsysteem.

# Uitvoering en weerslag

## Test 1 - Opzetten VM's:
- N.v.t

## Test 2 - Controle IP-adressering

- Uitvoer:
  ```
     [admin@bravo1 ~]$ sudo cat /var/named/green.local
    ; Hash: 2864da7d9234da15fb0462281f9dbff8 17121812
    ; Zone file for green.local
    ; Ansible managed

    $ORIGIN green.local.
    $TTL 1W

    @ IN SOA bravo1.green.local. hostmaster.green.local. (
      17121812
      1D
      1H
      1W
      1D )

                         IN  NS     bravo1.green.local.
                         IN  NS     charlie1.green.local.

    @                    IN  MX     10  delta1.green.local.

    bravo1               IN  A      172.16.128.133
    ns1                  IN  CNAME  bravo1
    charlie1             IN  A      172.16.128.134
    ns2                  IN  CNAME  charlie1
    alfa1                IN  A      172.16.128.132
    ad                   IN  CNAME  alfa1
    delta1               IN  A      172.16.128.135
    mail                 IN  CNAME  delta1
    echo1                IN  A      172.16.128.136
    www                  IN  CNAME  echo1
    kilo1                IN  A      172.16.128.4
    dhcp                 IN  CNAME  kilo1
    lima1                IN  A      172.16.128.5
    files                IN  CNAME  lima1
    mike1                IN  A      172.16.128.6
    cms                  IN  CNAME  mike1
    november1            IN  A      172.16.128.7
    db                   IN  CNAME  november1
    oscar1               IN  A      172.16.128.8
    mon                  IN  CNAME  oscar1
    papa1                IN  A      172.16.128.9
    pxe                  IN  CNAME  papa1
    quebec1              IN  A      172.16.128.10
    dnsfwd               IN  CNAME  quebec1
    virt1                IN  A      172.16.128.130
    virt2                IN  A      172.16.128.131
    virt3                IN  A      172.16.128.2
    virt4                IN  A      172.16.128.3
    [admin@bravo1 ~]$
  ```
## Test 3 -  Zones controleren

- Uitvoer:
  ```
    [admin@bravo1 ~]$ sudo cat /etc/named.conf
    //
    // named.conf
    //
    // Ansible managed
    //
    acl "acl1" {
    172.16.128/24;
    };

    options {
    listen-on port 53 { any; };
    listen-on-v6 port 53 { ::1; };
    directory   "/var/named";
    dump-file   "/var/named/data/cache_dump.db";
    statistics-file "/var/named/data/named_stats.txt";
    memstatistics-file "/var/named/data/named_mem_stats.txt";
    allow-query     { any; };
    allow-transfer  { "acl1"; };

    recursion no;

    rrset-order { order random; };

    dnssec-enable yes;
    dnssec-validation yes;
    dnssec-lookaside auto;

    /* Path to ISC DLV key */
    bindkeys-file "/etc/named.iscdlv.key";

    managed-keys-directory "/var/named/dynamic";

    pid-file "/run/named/named.pid";
    session-keyfile "/run/named/session.key";
    };

    logging {
    channel default_debug {
      file "data/named.run";
      severity dynamic;
      print-time yes;
    };
    };

    include "/etc/named.root.key";
    include "/etc/named.rfc1912.zones";

    zone "green.local" IN {
    type master;
    file "green.local";
    notify yes;
    allow-update { none; };
    };

    zone "128.16.172.in-addr.arpa" IN {
    type master;
    file "128.16.172.in-addr.arpa";
    notify yes;
    allow-update { none; };
    };

    [admin@bravo1 ~]$
  ```

## Test 4 - Replicatie naar 'charlie1'

- Uitvoer:
  ```
    [admin@charlie1 ~]$ sudo ls -l /var/named/slaves
    total 8
    -rw-r--r--. 1 named named 1341 Dec 18 13:37 128.16.172.in-addr.arpa
    -rw-r--r--. 1 named named 1704 Dec 18 13:33 green.local
    [admin@charlie1 ~]$
  ```
## Test 5 - Scripttest master

- Uitvoer:
  ```
  ✓ Het `dig` commando zou moeten geïnstalleerd zijn.
  ✓ Het hoofdconfiguratiebestand named.conf zou syntactisch correct moeten zijn.
  ✓ De forward zone bestand zou syntactisch correct moeten zijn.
  ✓ Het reverse zone bestand zou syntactisch correct moeten zijn.
  ✓ De service zou moeten draaien.
  ✓ Forward lookups van publieke servers uit VLAN 50.
  ✓ Forward lookups van interne servers uit VLAN 30.
  ✓ Reverse lookups van publieke servers uit VLAN 50.
  ✓ Reverse lookups van interne servers uit VLAN 30.
  ✓ Alias lookups public van publieke servers in VLAN 30.
  ✓ Alias lookups private servers uit VLAN 50.
  ✓ Forward lookups van virtuele machines.
  ✓ Reverse lookups van virtuele machines.

  13 tests, 0 failures
  ```

## Test 6 - Scripttest slave

- Uitvoer:
  ```
  ✓ Het `dig` commando zou moeten geïnstalleerd zijn.
  ✓ Het hoofdconfiguratiebestand named.conf zou syntactisch correct moeten zijn.
  ✓ De server zou moeten ingesteld zijn als slave.
  ✓ De server zou requests moeten forwarden naar de master server.
  ✓ Er zou geen forward zone bestand mogen zijn.
  ✓ De service zou moeten draaien.
  ✓ Forward lookups van publieke servers uit VLAN 50.
  ✓ Forward lookups van interne servers uit VLAN 30.
  ✓ Reverse lookups van publieke servers uit VLAN 50.
  ✓ Reverse lookups van interne servers uit VLAN 30.
  ✓ Alias lookups public van publieke servers in VLAN 30.
  ✓ Alias lookups private servers uit VLAN 50.
  ✓ Forward lookups van virtuele machines
  ✓ Reverse lookups van virtuele machines.

  14 tests, 0 failures
  ```


## Test 7 - Host DNS bereiken (MacOS of Linux (dig-commando))

- Uitvoer:
  ```
  GianniVanHavermaet: ~/Desktop  
  $ dig @172.16.128.133 -x 172.16.128.4 +short
  kilo1.green.local.
  GianniVanHavermaet: ~/Desktop  
  $ dig @172.16.128.133 kilo1.green.local +short
  172.16.128.4
  GianniVanHavermaet: ~/Desktop  
  $ dig @172.16.128.134 -x 172.16.128.4 +short
  kilo1.green.local.
  GianniVanHavermaet: ~/Desktop  
  $ dig @172.16.128.134 kilo1.green.local +short
  172.16.128.4

  ```

## Testinfo

Uitvoerder(s) test: Gianni Van Havermaet
Uitgevoerd op: 18/12/2017 om 16u20
