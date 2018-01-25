# Testplan : Kilo1 DHCP-server

**Opsteller(s) testplan:** Gianni Van Havermaet, Kasper Van Damme

Dit testplan zal de werking van de DHCP-server testen, zijnde `kilo1`.

Checklist

- [ ] Opstarten slaagt en start op zonder errors.
- [ ] DHCP-installatie is voltooid
- [ ] DHCP-service draait
- [ ] DHCP-instellingen komen overeen met de verwachtingen in IP-adressering.
- [ ] Client krijgt een IP-adres via de DHCP-server


## Test 1 - opstarten VM:

1. Ga vanop de host-machine naar de map met de vagrantfile van het project via de command-line.
2. Als je je in de map bevindt, typ het volgende commando om te controleren of de vm's al dan niet zijn aangemaakt.
3. Maak gebruik van het commando: `vagrant status`.


* Hier krijg je een lijst van machines met hun status, de vm Kilo1 zou "not created" moeten zijn, als dit niet zo is voer je het commando `vagrant destroy -f kilo1` uit
* Voor het aanmaken van de vm kilo1 typ je het volgende commando: `vagrant up kilo1`


* Verwachte resultaten:
    - Via de GUI van VirtualBox zien we een dockerhost-VM draaien
    - De laatste uitvoerlijn op de commandline heeft volgende uitvoer

    ```
    ==> kilo1: PLAY RECAP ***********************************************
    ==> kilo1: kilo1     : ok=7    changed=5    unreachable=0    failed=0
    ```

## Test 2 - DHCP installatie:  

1. Ga in de vm met het commando `vagrant ssh kilo1`
2. Typ het volgende commando om the controleren of dhcp geïnstaleerd is op de vm: `rpm -q dhcp`

* Verwachte resultaat:  

  ```
    dhcp-4.2.5-58.el7.centos.x86_64
  ```



## Test 3 - DHCP service:

1. Voor het controleren van de status van dhcp typen we het volgende commando: `systemctl status dhcpd.service`

* De verwachte uitvoer na dit commando:

  ```
     ● dhcpd.service - DHCPv4 Server Daemon
  Loaded: loaded (/usr/lib/systemd/system/dhcpd.service; enabled; vendor preset: disabled)
  Active: active (running) since Sun 2017-10-22 11:37:56 UTC; 25min ago
   Docs: man:dhcpd(8)
         man:dhcpd.conf(5)
  Main PID: 4040 (dhcpd)
  Status: "Dispatching packets..."
  CGroup: /system.slice/dhcpd.service
         └─4040 /usr/sbin/dhcpd -f -cf /etc/dhcp/dhcpd.conf -user dhcpd -group dhcpd --no-pid
  ```

## Test 4 - dhcpd.conf

1. Gebruik volgend commando om het configuratiebestand van de dhcpd service te bekijken: `sudo cat /etc/dhcp/dhcpd.conf`

* Verwachte uitvoer van de DHCP configuratiefile:

  ```
  # ISC DHCPD configuration -- don't edit manually!
  #
  # Ansible managed

  #
  # Global options
  #
  next-server 172.16.128.7;
  default-lease-time 28800;
  max-lease-time 43200;
  option subnet-mask 255.255.0.0;
  option domain-name "green.local";
  option domain-name-servers 172.16.128.131, 172.16.128.132;

  #
  # Includes

  #

  #
  # Subnet declarations
  #
  subnet 172.16.0.0 netmask 255.255.0.0 {
  option routers 10.0.2.2;
  option domain-name-servers 172.16.128.131, 172.16.128.132;
  range 172.16.0.1 172.16.127.254;
  }
  ```

## Test 5 - DHCP-client

1. Om te kijken of de DHCP-server echt een IP-adres toegewezen krijgt, gaan we dit effectief testen.
  - Maak manueel een nieuwe virtuele machine (Fedora, Ubuntu, ...)
  - Geef deze VM twee interne adapters.
  - Wijzig het MAC adres van één van de adapters naar '00:11:22:33:44:02'. (001122334402)
  - Boot de virtuele machine

* Verwacht resultaat:
  - Wanneer de DHCP-client is opgestart, bekijk je de netwerksettings in de GUI of met het commando `ip a`
  - De ene interface zou een IP-adres moeten krijgen uit de range (dynamisch). Hier wordt bijvoorbeeld het IP-adres `172.16.0.100`.
  - De andere interface zou een IP-adres moeten krijgen op basis van zijn MAC adres. Het MAC-adres dat je hebt ingesteld, zou moeten overeen komen met het IP-adres `172.16.0.2` uit de configuratiefile van DHCP.

- Belangrijk: Bij deze test ook graag een van volgende zaken:
    - Besturingsysteem van de test VM
    - Netwerkconfiguratie in VirtualBox
    - Uitvoer van `ip a` op de commandline
