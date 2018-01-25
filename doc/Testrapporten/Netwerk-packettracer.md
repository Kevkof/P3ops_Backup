# Testrapport : Packet tracer
- [x] Bouw een basis versie van het netwerk (3 routers waarvan 1 firewall en 3 switches) Let op de juiste poorten!
  - [x] Voor de firewall router dien je nog IP adressen toe te wijzen aan g0/0 en g0/1 (dit is nodig om de werking te simuleren)
    - [x] int g0/0 krijgt ip 172.16.129.14  en int g0/1 krijgt 172.16.129.9 (0/1 gaat naar Switch3)
    - [x] voer de volgende commandos uit:      
      en   
      conf t   
      int g0/1   
      ip ad 172.16.129.9 255.255.255.252   
      no sh   
      int g0/0   
      ip ad 172.16.129.14 255.255.255.252   
      no sh   
      ip route 0.0.0.0 0.0.0.0 g0/0   
      ip route 172.16.0.0 255.255.128.0 g0/1   
      ip route 172.16.128.0 255.255.255.128 g0/1   
      ip route 172.16.128.128 255.255.255.128 g0/1   
      ip route 172.16.129.8 255.255.255.252 g0/1   
      ip route 172.16.129.12 255.255.255.252 g0/1   
      do wr   
- [x] Voor voor elk device de correspondere commandos uit ( aka. voor routerIN het bestand routerIN.MD )
- [x] Alle devices kunnen naar elkaar pingen
	- [x] Device in VLAN 30 kan pingen naar VLAN 20 en omgekeerd
	- [x] Device in VLAN 50 kan pingen naar VLAN 30 en omgekeerd
	- [x] Device in VLAN 20 kan pingen naar VLAN 50 en omgekeerd
	- [x] Router0 kan pingen naar alle devices en omgekeerd
- [x] Alle devices hebben een correct IP toegewezen
- [x] De opstelling komt overeen met de fysieke en logische topologie

## Notes
- Eventueel voor een latere test de werkwijze iets duidelijker zetten

Auteur(s) testplan: Kjell Viaene
Uitvoerder test: Kevin Verlinde
