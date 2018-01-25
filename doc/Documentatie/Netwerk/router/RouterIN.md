en
conf t
hostname RouterIN
int f0/1.50
encapsulation dot1q 50
ip address 172.16.128.129 255.255.255.128
int f0/1.30
encapsulation dot1q 30
ip address 172.16.128.1 255.255.255.128
int f0/1.20
encapsulation dot1q 20
ip address 172.16.0.1 255.255.128.0
ip helper-address 172.16.128.4

int f0/1
no shutdown

int f0/0
no shutdown
ip address 172.16.129.10 255.255.255.252
exit

ip route 172.16.0.0 255.255.128.0 f0/1.20
ip route 172.16.128.0 255.255.255.128 f0/1.30
ip route 172.16.128.128 255.255.255.128 f0/1.50
ip route 172.16.129.12 255.255.255.252 172.16.129.9
ip route 0.0.0.0 0.0.0.0 172.16.129.13

do write
