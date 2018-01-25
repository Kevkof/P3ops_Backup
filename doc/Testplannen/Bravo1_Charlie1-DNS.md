# Testplan : Bravo1 & Charlie1 DNS-servers

**Opsteller(s) testplan:** Gianni Van Havermaet, Kasper Van Damme

Dit testplan zal de werking van de DNS-server testen, zijnde `bravo1` (master DNS) en `charlie1` (slave DNS).

Checklist

- [ ] Opstarten slaagt en start op zonder errors.
- [ ] IP-adressing komt overeen met documentatie IP-adressing.
- [ ] Zones op master zijn correct.
- [ ] Replicatie heeft bestanden van master naar slave gekopieerd
- [ ] Testscript van DNS-master heeft geen failures.
- [ ] Testscript van DNS-slave heeft geen failures.
- [ ] DNS bereikbaar vanaf hostsysteem.

## Test 1 - Opzetten VM's:

1. Ga vanop de host-machine naar de lokale working directory van het project.
2. Voer het volgende commando uit: `vagrant status`

    - Er zou vervolgens een lijst van virtuele machines moeten getoond worden. Daar zouden 'bravo1' en 'charie1' de status `not created` moeten hebben. Indien dit niet het geval is, voer het commando `vagrant destroy -f bravo1 charlie1`
3. Start vervolgens de DNS-servers op met het commando `vagrant up bravo1 charlie1`. (Nodig roles dienen geïnstalleerd te zijn)
    - Verwacht resultaat is dat dit uitvoert zonder errors.
      ```
      PLAY RECAP *************************************************
      bravo1      : ok=36   changed=21   unreachable=0    failed=0
      ```
      ```
      PLAY RECAP *************************************************
      charlie1    : ok=34   changed=19   unreachable=0    failed=0
      ```


 ## Test 2 - Controle IP-adressering:  

1. Typ op het hostsysteem het commando `vagrant ssh bravo1`
2. We kijken inhoud van de file `/var/named/green.local` met het commando
    ```
    sudo cat /var/named/green.local
    ```
3. Het scherm toont volgend uitvoer:

    ```
      ; Hash: 9221d4a15c7740c1c0160401e1dd988e 17110611
      ; Zone file for green.local
      ; Ansible managed

      $ORIGIN green.local.
      $TTL 1W

      @ IN SOA bravo1.green.local. hostmaster.green.local. (
        17110611
        1D
        1H
        1W
        1D )

                           IN  NS     bravo1.green.local.
                           IN  NS     charlie1.green.local.


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

    ```
4.  Controleer of de IP-adressing in dit configuratiebestand overeenkomen met [documentatie](../../doc/netwerk/ip-subnetting.md) van het project die de adrestabel toont.


## Test 3 -  Zones controleren:  


1. Gebruik volgend commando om de configuratie van de named service te bekijken: `sudo cat /etc/named.conf`

2. De verwachte zones zouden er als volgt moeten uitzien :   
    ```
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

      ```

## Test 4 - Replicatie naar 'charlie1'

1. Indien nog ingelogd op `bravo1`, log uit met het commando `logout`.
2. Log in op `charlie` met het commando `vagrant ssh charlie1`
3. Gebruik het commando `sudo ls -l /var/named/slaves`. Dit zal tonen dat de zonesfiles zijn gekopieerd van master naar slave. Volgende bestanden zijn aanwezig.
  ```
  -rw-r--r--. 1 named named 1064 Oct 23 13:50 128.16.172.in-addr.arpa
  -rw-r--r--. 1 named named 1464 Oct 23 13:50 green.local
  ```
## Test 5 - Scripttest master

- Om de DNS-master verder te testen is er een automatische testschript aanwezig die volgende zaken testen:
  - Het 'dig' commando zou moeten geïnstalleerd zijn.
  - Het hoofdconfiguratiebestand named.conf zou syntactisch correct moeten zijn.
  - De forward zone bestand zou syntactisch correct moeten zijn.
  - Het reverse zone bestand zou syntactisch correct moeten zijn.
  - De service zou moeten draaien.
  - Forward lookups van publieke servers uit VLAN 50 zijn correct
  - Forward lookups van interne servers uit VLAN 30 zijn correct
  - Reverse lookups van publieke servers uit VLAN 50 zijn correct
  - Reverse lookups van interne servers uit VLAN 30 zijn correct
  - Alias lookups public van publieke servers in VLAN 30 zijn correct
  - Alias lookups private servers uit VLAN 50 zijn correct
  - Forward lookups van virtuele machines zijn correct
  - Reverse lookups van virtuele machines zijn correct

1. Uitvoeren van het script kan door in te loggen op de master DNS Bravo1 met commando `vagrant ssh bravo1`. Log indien nodig eerst uit als je nog bent ingelogd op een andere VM.
2. Voer het testscript uit met het commando `sudo /vagrant/test/runbats.sh`.
3. Verwachte resultaat is dat alle testen slagen.
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

- Om de DNS-master verder te testen is er een automatische testschript aanwezig die volgende zaken testen:
  - Het 'dig' commando zou moeten geïnstalleerd zijn.
  - Het hoofdconfiguratiebestand named.conf zou syntactisch correct moeten zijn.
  - De server zou moeten ingesteld zijn als slave.
  - De server zou requests moeten forwarden naar de master server.
  - Er zou geen forward zone bestand mogen zijn.
  - De service zou moeten draaien.
  - Forward lookups van publieke servers uit VLAN 50 zijn correct
  - Forward lookups van interne servers uit VLAN 30 zijn correct
  - Reverse lookups van publieke servers uit VLAN 50 zijn correct
  - Reverse lookups van interne servers uit VLAN 30 zijn correct
  - Alias lookups public van publieke servers in VLAN 30 zijn correct
  - Alias lookups private servers uit VLAN 50 zijn correct
  - Forward lookups van virtuele machines zijn correct
  - Reverse lookups van virtuele machines zijn correct

1. Uitvoeren van het script kan door in te loggen op de master DNS Bravo1 met commando `vagrant ssh charlie1`. Log indien nodig eerst uit als je nog bent ingelogd op een andere VM.
2. Voer het testscript uit met het commando `sudo /vagrant/test/runbats.sh`.
3. Verwachte resultaat is dat alle testen slagen.
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

1. Ook vanop je host systeem zouden de DNS-server toegankelijk moeten zijn.
2. Dit kan kort getest worden met volgend commando's.
    - `dig @172.16.128.133 -x 172.16.128.4 +short`  (test met master-DNS)
      - Verwachte output: `kilo1.green.local.`
    - `dig @172.16.128.133 kilo1.green.local +short` (test met master-DNS)
      - Verwachte output: `172.16.128.4`
    - `dig @172.16.128.134 -x 172.16.128.4 +short`  (test met slave-DNS)
      - Verwachte output: `kilo1.green.local.`
    - `dig @172.16.128.134 kilo1.green.local +short` (test met slave-DNS)
      - Verwachte output: `172.16.128.4`  
3. Al deze testen zouden de verwacht output moeten tonen.
