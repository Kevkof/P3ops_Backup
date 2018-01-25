en
conf t
hostname Router0
ip access-list standard ACL
permit any
exit
ip access-list extended INTERNET
permit tcp any any
permit ip any any
ip nat inside source list ACL interface f0/1 overload
int f0/1
ip nat outside
ip access-group INTERNET in
ip ad dhcp
no sh
int f0/0
ip nat inside
ip address 172.16.129.13 255.255.255.252
no sh
exit
ip route 0.0.0.0 0.0.0.0 FastEthernet0/0
ip route 172.16.0.0 255.255.0.0 172.16.129.9
ip route 172.16.0.0 255.255.128.0 172.16.129.9
ip route 172.16.0.0 255.255.128.0 172.16.129.14
ip route 172.16.128.0 255.255.255.128 172.16.129.14
ip route 172.16.128.128 255.255.255.128 172.16.129.14
ip route 172.16.129.12 255.255.255.252 172.16.129.14
ip route 172.16.129.8 255.255.255.252 172.16.129.14
ip route 172.18.0.0 255.255.0.0 FastEthernet0/0
ip route 192.168.0.0 255.255.255.0 FastEthernet0/0
ip route 192.168.2.0 255.255.255.0 FastEthernet0/0

end
copy running-config startup-config


(default route moet eigenlijk f0/1 -> DHCP ip zijn)

( als niet werkt, .14 vervangen door .9)