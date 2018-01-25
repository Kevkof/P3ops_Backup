```
en
conf t
hostname Switch1L2
vlan 50
vlan 30
vlan 20
int g0/1
switchport mode trunk
switchport trunk allowed vlan 50,30,20
no shut
int range f0/2-24
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
```