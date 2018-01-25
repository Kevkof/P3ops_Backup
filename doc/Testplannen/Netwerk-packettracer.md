# Testplan : Packet tracer
- [ ] Bouw een basis versie van het netwerk (3 routers waarvan 1 firewall en 3 switches) Let op de juiste poorten!
  - [ ] Voor de firewall router dien je nog IP adressen toe te wijzen aan g0/0 en g0/1 (dit is nodig om de werking te simuleren)
    - [ ] int g0/0 krijgt ip 172.16.129.14  en int g0/1 krijgt 172.16.129.9 (0/1 gaat naar Switch3
    - [ ] voer de volgende commandos uit:      
      en <br />
      conf t <br />
      int g0/1 <br />
      ip ad 172.16.129.9 255.255.255.252 <br />
      no sh <br />
      int g0/0 <br />
      ip ad 172.16.129.14 255.255.255.252 <br />
      no sh <br />
      ip route 0.0.0.0 0.0.0.0 g0/0 <br />
      ip route 172.16.0.0 255.255.128.0 g0/1 <br />
      ip route 172.16.128.0 255.255.255.128 g0/1 <br />
      ip route 172.16.128.128 255.255.255.128 g0/1 <br />
      ip route 172.16.129.8 255.255.255.252 g0/1 <br />
      ip route 172.16.129.12 255.255.255.252 g0/1 <br />
      do wr <br />
- [ ] Voor voor elk device de correspondere commandos uit ( aka. voor routerIN het bestand routerIN.MD )
- [ ] Alle devices kunnen naar elkaar pingen
	- [ ] Device in VLAN 30 kan pingen naar VLAN 20 en omgekeerd
	- [ ] Device in VLAN 50 kan pingen naar VLAN 30 en omgekeerd
	- [ ] Device in VLAN 20 kan pingen naar VLAN 50 en omgekeerd
	- [ ] Router0 kan pingen naar alle devices en omgekeerd
- [ ] Alle devices hebben een correct IP toegewezen
- [ ] De opstelling komt overeen met de fysieke en logische topologie

Auteur(s) testplan: Kjell Viaene
