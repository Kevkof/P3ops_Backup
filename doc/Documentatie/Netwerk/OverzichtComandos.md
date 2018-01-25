Router0:

en
conf t
int s0/0/0
no sh
int g0/0
ip address 172.16.129.9 255.255.255.252
no sh
exit
ip route 0.0.0.0 0.0.0.0 s0/0/0
ip route 172.16.0.0 255.255.0.0 g0/0

end
copy running-config startup-config


----------------------------------
RouterIN:

en
conf t
int g0/0.50
encapsulation dot1q 50
ip address 172.16.128.129 255.255.255.128
int g0/0.30
encapsulation dot1q 30
ip address 172.16.128.1 255.255.255.128
int g0/0.20
encapsulation dot1q 20
ip address 172.16.0.1 255.255.128.0

int g0/0
no shutdown

int g0/1
no shutdown
ip address 172.16.129.10 255.255.255.252
exit

ip route 172.16.129.8 255.255.255.252 g0/1
ip route 172.16.129.12 255.255.255.252 g0/1
ip route 172.16.0.0 255.255.128.0 g0/0.20
ip route 172.16.128.0 255.255.255.128 g0/0.30
ip route 172.16.128.128 255.255.255.128 g0/0.50
ip route 0.0.0.0 0.0.0.0 g0/1

do write
-----------------------


en
conf t
hostname Switch3L2
vlan 50
vlan 30
vlan 20
int g0/1
switchport mode trunk
switchport trunk allowed vlan 50,30,20
no shut
int range f0/2-6
switchport mode access
switchport access vlan 50
no shut
int f0/1
switchport mode trunk
switchport trunk allowed vlan 50,30,20
no shut
int vlan 99
ip add 172.16.129.4 255.255.255.248
no shut

do write



------------------------


en
conf t
hostname Switch2L2
vlan 50
vlan 30
vlan 20
int f0/1
switchport mode trunk
switchport trunk allowed vlan 50,30,20
no shut
int range f0/3-8
switchport mode access
switchport access vlan 30
no shut
int f0/2
switchport mode trunk
switchport trunk allowed vlan 50,30,20
no shut
int vlan 99
ip add 172.16.129.3 255.255.255.248
no shut

do write


------------------------

en
conf t
hostname Switch1L2
vlan 50
vlan 30
vlan 20
int f0/1
switchport mode trunk
switchport trunk allowed vlan 50,30,20
no shut
int range f0/2-6
switchport mode access
switchport access vlan 20
no shut
do write
int vlan 99
ip add 172.16.129.2 255.255.255.248
no shut