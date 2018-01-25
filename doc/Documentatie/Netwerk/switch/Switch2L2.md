```
en
conf t
hostname Switch2L2
vlan 50
vlan 30
vlan 20
int g0/1
switchport mode trunk
switchport trunk allowed vlan 50,30,20
no shut
int range f0/1-24
switchport mode access
switchport access vlan 30
no shut
int g0/2
switchport mode trunk
switchport trunk allowed vlan 50,30,20
no shut
int vlan 99
ip add 172.16.129.3 255.255.255.248
no shut
do write

```