# Testrapport: Kilo 1 DHCP

## Test 1 - opstarten VM:


Commando uitgevoerd:
```
$ vagrant status
```

Uitvoer:
```
Current machine states:

alfa1                     not created (virtualbox)
papa1                     poweroff (virtualbox)
lima1                     not created (virtualbox)
bravo1                    not created (virtualbox)
charlie1                  not created (virtualbox)
echo1                     not created (virtualbox)
mike1                     not created (virtualbox)
november1                 not created (virtualbox)
oscar1                    not created (virtualbox)
quebec1                   not created (virtualbox)
kilo1                     not created(virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.

```

Commando uitgevoerd:
```
vagrant up kilo1
```

Uitvoer(laatste uitvoerlijn):
```
==> kilo1: PLAY RECAP *********************************************************************
==> kilo1: kilo1                      : ok=7    changed=5    unreachable=0    failed=0
==> kilo1: + set +x
```

## Test 2 - DHCP installatie:

Commando uitgevoerd:
```
rpm -q dhcp`
```
Uitvoer:
```
dhcp-4.2.5-58.el7.centos.x86_64
```

## Test 3 - DHCP Service
Commando uitgevoerd:
```
systemctl status dhcpd.service
```

Uitvoer:
```
● dhcpd.service - DHCPv4 Server Daemon
   Loaded: loaded (/usr/lib/systemd/system/dhcpd.service; enabled; vendor preset: disabl
ed)
   Active: active (running) since Sat 2017-11-04 14:38:28 UTC; 9min ago
     Docs: man:dhcpd(8)
           man:dhcpd.conf(5)
 Main PID: 4048 (dhcpd)
   Status: "Dispatching packets..."
   CGroup: /system.slice/dhcpd.service
           └─4048 /usr/sbin/dhcpd -f -cf /etc/dhcp/dhcpd.conf -user dhcpd -group dhcp...
```

## Test 4 - dhcpd.conf

Commando uitgevoerd:
```
sudo cat /etc/dhcp/dhcpd.conf
```
Uitvoer:
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
  range 172.16.0.100 172.16.127.254;
}
```

## Test 5 - DHCP-client

- [x] DHCP client werd aangemaakt met enkel een interne netwerkadapter. Het betreffende IP adres, dat uitgedeeld werd door DHCP, is 172.16.0.101 (.100 werd uitgedeeld aan een host waar niet verder mee getest werd).

- [x] Via de GUI kan men zien dat de DHCP client het IP adres 172.16.0.101 toegewezen gekregen heeft.

    ![gui](https://imgur.com/fRNT1eN.png)

- [x] Via het commando `ip a` kan men eveneens zien dat de DHCP client het IP adres 172.16.0.101 toegewezen gekregen heeft.

    ![ipa](https://imgur.com/4XOjCmS.png)    

## Conclusie

- [x] Opstarten slaagt en start op zonder errors.
- [x] DHCP-installatie is voltooid
- [x] DHCP-service draait
- [x] DHCP-instellingen komen overeen met de verwachtingen in IP-adressering.
- [x] Client krijgt een IP-adres via de DHCP-server


## Testinfo

Uitvoerder(s) test: Jodie De Pestel, Ruben Bruggeman
Uitgevoerd op: 02/11/2017, 25/11/2017
