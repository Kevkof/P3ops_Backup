# RouterIN
RouterIN#show run
Building configuration...

Current configuration : 1296 bytes
!
version 12.4
service timestamps debug datetime msec
service timestamps log datetime msec
no service password-encryption
!
hostname RouterIN
!
boot-start-marker
boot-end-marker
!
!
no aaa new-model
ip cef
!
!
!
!
!
!
!
!
!
interface FastEthernet0/0
 no ip address
 duplex auto
 speed auto
!
interface FastEthernet0/0.20
 encapsulation dot1Q 20
 ip address 172.16.0.1 255.255.128.0
!
interface FastEthernet0/0.30
 encapsulation dot1Q 30
 ip address 172.16.128.1 255.255.255.128
!
interface FastEthernet0/0.50
 encapsulation dot1Q 50
 ip address 172.16.128.129 255.255.255.128
!
interface FastEthernet0/1
 ip address 172.16.129.10 255.255.255.252
 duplex auto
 speed auto
!
interface Serial0/1/0
 no ip address
 clock rate 128000
!
interface Serial0/1/1
 no ip address
 shutdown
 clock rate 125000
!
ip forward-protocol nd
ip route 0.0.0.0 0.0.0.0 FastEthernet0/1
ip route 0.0.0.0 0.0.0.0 Serial0/1/0
ip route 172.16.0.0 255.255.128.0 FastEthernet0/0.20
ip route 172.16.128.0 255.255.255.128 FastEthernet0/0.30
ip route 172.16.128.128 255.255.255.128 FastEthernet0/0.50
ip route 172.16.129.8 255.255.255.252 FastEthernet0/1
ip route 172.16.129.12 255.255.255.252 FastEthernet0/1
!
ip http server
!
!
control-plane
!
!
line con 0
line aux 0
line vty 0 4
 login
!
scheduler allocate 20000 1000
end



# Router0
show ip nat statistics
Total active translations: 295 (0 static, 295 dynamic; 295 extended)
Outside interfaces:
  FastEthernet0/0
Inside interfaces:
  FastEthernet0/1, Serial0/1/0
Hits: 1720724  Misses: 6217
CEF Translated packets: 1707157, CEF Punted packets: 37593
Expired translations: 13098
Dynamic mappings:
-- Inside Source
[Id: 1] access-list TEST interface FastEthernet0/0 refcount 295
Appl doors: 0
Normal doors: 0
Queued Packets: 0
Router0#


Router0#show run
Building configuration...

Current configuration : 1131 bytes
!
version 12.4
service timestamps debug datetime msec
service timestamps log datetime msec
no service password-encryption
!
hostname Router0
!
boot-start-marker
boot-end-marker
!
!
no aaa new-model
ip cef
!
!
!
!
!
!
!
!
!
interface FastEthernet0/0
 ip address dhcp
 ip access-group INTERNET in
 ip nat outside
 ip nat enable
 duplex auto
 speed auto
!
interface FastEthernet0/1
 ip address 172.16.129.9 255.255.255.252
 ip nat inside
 ip nat enable
 duplex auto
 speed auto
!
interface Serial0/1/0
 no ip address
 ip nat inside
 no fair-queue
 clock rate 125000
!
interface Serial0/1/1
 no ip address
 shutdown
 clock rate 125000
!
ip forward-protocol nd
ip route 0.0.0.0 0.0.0.0 FastEthernet0/0
ip route 172.16.0.0 255.255.0.0 Serial0/1/0
ip route 172.16.0.0 255.255.0.0 FastEthernet0/1
!
ip http server
ip nat inside source list TEST interface FastEthernet0/0 overload
!
ip access-list standard TEST
 permit any
ip access-list standard test
!
ip access-list extended INTERNET
 permit tcp any any established
 permit ip any any
!
!
control-plane
!
!
line con 0
line aux 0
line vty 0 4
 login
!
scheduler allocate 20000 1000
end

Router0#

# Switch1L2
Switch1L2#show run
Building configuration...

Current configuration : 1671 bytes
!
version 12.2
no service pad
service timestamps debug uptime
service timestamps log uptime
no service password-encryption
!
hostname Switch1L2
!
!
no aaa new-model
system mtu routing 1500
ip subnet-zero
!
!
!
!
no file verify auto
spanning-tree mode pvst
spanning-tree extend system-id
!
vlan internal allocation policy ascending
!
interface FastEthernet0/1
 switchport trunk allowed vlan 20,30,50
 switchport mode trunk
!
interface FastEthernet0/2
 switchport access vlan 50
 switchport mode access
!
interface FastEthernet0/3
 switchport access vlan 50
 switchport mode access
!
interface FastEthernet0/4
 switchport access vlan 50
 switchport mode access
!
interface FastEthernet0/5
 switchport access vlan 50
 switchport mode access
!
interface FastEthernet0/6
 switchport access vlan 50
 switchport mode access
!
interface FastEthernet0/7
!
interface FastEthernet0/8
!
interface FastEthernet0/9
!
interface FastEthernet0/10
!
interface FastEthernet0/11
!
interface FastEthernet0/12
!
interface FastEthernet0/13
!
interface FastEthernet0/14
!
interface FastEthernet0/15
!
interface FastEthernet0/16
!
interface FastEthernet0/17
!
interface FastEthernet0/18
!
interface FastEthernet0/19
!
interface FastEthernet0/20
!
interface FastEthernet0/21
!
interface FastEthernet0/22
!
interface FastEthernet0/23
!
interface FastEthernet0/24
!
interface GigabitEthernet0/1
 switchport trunk allowed vlan 20,30,50
 switchport mode trunk
!
interface GigabitEthernet0/2
!
interface Vlan1
 no ip address
 no ip route-cache
 shutdown
!
interface Vlan99
 ip address 172.16.129.4 255.255.255.248
 no ip route-cache
!
ip http server
!
control-plane
!
!
line con 0
line vty 5 15
!
end

# Switch2L2
Switch2L2#show run
Building configuration...

Current configuration : 1894 bytes
!
version 12.2
no service pad
service timestamps debug uptime
service timestamps log uptime
no service password-encryption
!
hostname Switch2L2
!
!
no aaa new-model
system mtu routing 1500
ip subnet-zero
!
!
!
!
no file verify auto
spanning-tree mode pvst
spanning-tree extend system-id
!
vlan internal allocation policy ascending
!
interface FastEthernet0/1
 switchport access vlan 30
 switchport trunk allowed vlan 20,30,50
 switchport mode access
!
interface FastEthernet0/2
 switchport access vlan 30
 switchport trunk allowed vlan 20,30,50
 switchport mode access
!
interface FastEthernet0/3
 switchport access vlan 30
 switchport mode access
!
interface FastEthernet0/4
 switchport access vlan 30
 switchport mode access
!
interface FastEthernet0/5
 switchport access vlan 30
 switchport mode access
!
interface FastEthernet0/6
 switchport access vlan 30
 switchport mode access
!
interface FastEthernet0/7
 switchport access vlan 30
 switchport mode access
!
interface FastEthernet0/8
 switchport access vlan 30
 switchport mode access
!
interface FastEthernet0/9
!
interface FastEthernet0/10
!
interface FastEthernet0/11
!
interface FastEthernet0/12
!
interface FastEthernet0/13
!
interface FastEthernet0/14
!
interface FastEthernet0/15
!
interface FastEthernet0/16
!
interface FastEthernet0/17
!
interface FastEthernet0/18
!
interface FastEthernet0/19
!
interface FastEthernet0/20
!
interface FastEthernet0/21
!
interface FastEthernet0/22
!
interface FastEthernet0/23
!
interface FastEthernet0/24
!
interface GigabitEthernet0/1
 switchport trunk allowed vlan 20,30,50
 switchport mode trunk
!
interface GigabitEthernet0/2
 switchport trunk allowed vlan 20,30,50
 switchport mode trunk
!
interface Vlan1
 no ip address
 no ip route-cache
!
interface Vlan99
 ip address 172.16.129.3 255.255.255.248
 no ip route-cache
!
ip http server
!
control-plane
!
!
line con 0
line vty 5 15
!
end
# Switch3L2

Switch3L2#show run
Building configuration...

Current configuration : 1727 bytes
!
version 12.2
no service pad
service timestamps debug datetime msec
service timestamps log datetime msec
no service password-encryption
!
hostname Switch3L2
!
boot-start-marker
boot-end-marker
!
!
no aaa new-model
system mtu routing 1500
ip subnet-zero
!
!
!
!
!
!
!
!
!
spanning-tree mode pvst
spanning-tree extend system-id
!
vlan internal allocation policy ascending
!
!
!
interface FastEthernet0/1
 switchport trunk allowed vlan 20,30,50
 switchport mode trunk
!
interface FastEthernet0/2
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/3
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/4
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/5
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/6
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/7
!
interface FastEthernet0/8
!
interface FastEthernet0/9
!
interface FastEthernet0/10
!
interface FastEthernet0/11
!
interface FastEthernet0/12
!
interface FastEthernet0/13
!
interface FastEthernet0/14
!
interface FastEthernet0/15
!
interface FastEthernet0/16
!
interface FastEthernet0/17
!
interface FastEthernet0/18
!
interface FastEthernet0/19
!
interface FastEthernet0/20
!
interface FastEthernet0/21
!
interface FastEthernet0/22
!
interface FastEthernet0/23
!
interface FastEthernet0/24
!
interface GigabitEthernet0/1
!
interface GigabitEthernet0/2
 switchport trunk allowed vlan 20,30,50
 switchport mode trunk
!
interface Vlan1
 no ip address
 no ip route-cache
!
interface Vlan99
 ip address 172.16.129.2 255.255.255.248
 no ip route-cache
!
ip http server
ip http secure-server
!
control-plane
!
!
line con 0
line vty 5 15
!
end
