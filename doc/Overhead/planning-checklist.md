# Planning + Checklist Eindrelease
## Planning en verantwoordelijkheden

# Dagplanning
- 12.30: Begin release
  - Lokaal netwerk opzetten + WAN : Kjell, Thomas en Seba (15 - 20 min)
  - Fysieke machines: Lander en Brecht. (20 minuten)
    - Machine opstarten
    - Git pull
    - Script uitvoeren

- 13.00: Runnen van playbook en firewall
  - Netwerk: Firewall begin en connectie met red.local: Kjell, Thomas en Seba.
  - Virt1
    - DNS master: Gianni en Kasper
    - LDAP: Lander
    - DNS slave: Kasper en Pim
  - Virt2
    - Echo: (in te delen door Aalst)
    - Delta: (in te delen door Aalst)
  - Virt3
    - Kilo: Gianni en Kasper
    - November: (in te delen door Aalst)(MariaDB)
    - Mike: (in te delen door Aalst)
    - Lima: David en Ruben
  - Virt4
    - Papa: Kevin en Ruben
    - Oscar: Brecht, Matti en Ruben
    - Quebec: Pim 
  - PC voor client
    - Clients: Tim

- 14.00: Testen van servers
  - Virt1
    - DNS master
      - Testscript
      - Testplan
    - LDAP
      - Testplan
    - DNS Slave
      - Testscript
      - Testplan
    - Virt2
      - Echo
        - Testplan
      - Delta
        - Testplan
    - Virt3
      - Kilo
        - Testplan
      - November
        - Testplan
      - Mike
        - Testplan
      - Lima
        - Testplan
    - Virt4
      - Papa
        - Testplan
      - Oscar
        - Testplan
      - Quebec
        - Testplan

- 14.30: Checklist doorlopen
  - Virt1
    - DNS master: Gianni en Kasper
    - LDAP: Lander
    - DNS slave: Kasper en Pim
  - Virt2
    - Echo: Robin en Stijn
    - Delta: Robbe en Pieter-Jan
  - Virt3
    - Kilo: Gianni en Kasper
    - November: Pieter-Jan
    - Mike: Florian & Jolan
    - Lima: David en Ruben
  - Virt4
    - Papa: Kevin en Ruben
    - Oscar: Brecht, Matti en Ruben
    - Quebec: Pim en Gianni


## Kanbanbord

### Layout

| To Do | Working | Testing                 | Done |
| ----- | ------- | ----------------------- | ---- |
|       |         | Standalone / Integratie |      |

### Kleurencode

| Kleur              | Betekenis                      |
| ------------------ | ------------------------------ |
| Lichtblauw (groot) | Groepering per fysieke machine |
| Roze               | Hoogste prioriteit             |
| Geel               | Medium prioriteit              |
| Groen              | Laagste prioriteit             |
| Blauw              | Issues of problemen            |

### Post-its

#### Lichtblauw (groot)

- Virt1 playbook runnen
- Virt2 playbook runnen
- Virt3 playbook runnen
- Virt4 playbook runnen

#### Roze
- Alfa - LDAP
- Bravo - DNS master
- Kilo - DHCP
- Papa - PXE
- Netwerk LAN
- Netwerk WAN
- Fysieke machine 1
- Fysieke machine 2
- Fysieke machine 3
- Fysieke machine 4

#### Geel
- Lima - Samba
- Mike - Database
- November - CMS
- Oscar - Monitoring
- Quebec - DNSmasq

#### Groen
- Charlie - DNS slave
- Delta - Mail
- Echo - Webserver

#### Onderverdeling Lichtblauw (groot)

| Virt1   | Virt2 | Virt3    | Virt4  |
| ------- | ----- | -------- | ------ |
| Alfa    | Echo  | Kilo     | Oscar  |
| Bravo   | Delta | Lima     | Papa   |
| Charlie |       | Mike     | Quebec |
|         |       | November |        |


## Implementatie checklist

Checklist gebaseerd op de projectbrochure

### Netwerk
- [ ] Alle routers zijn verbonden met seriele kabels
- [ ] Alle routers maken gebruik van een dynamisch routeringsalgoritme
- [ ] Doorverbinden met het internet wordt voorzien via de PFSense firewall
- [ ] ACLs op routers en/of switches beperken binnenkomende verkeer van andere domeinen tot de publieke servers en de protocollen die op de servers gebruikt worden.

### Alfa 1 (LDAP)

- [ ] Alle afdelingsgroepen zijn aanwezig
  - [ ] IT-Administratie
  - [ ] Verkoop
  - [ ] Administratie
  - [ ] Ontwikkeling
  - [ ] Directie
- [ ] Er zijn testgebruikers aanwezig voor elke groep

### Bravo 1 (DNS-master)

- [ ] DNS is bereikbaar vanop andere alle andere servers en workstations van green.local

### Charlie 1 (DNS-slave)

- [ ] Sychroniseert met bravo 1
- [ ] Bevat dus zelf geen zonebestanden

### Delta 1
- [ ] Mailserver maakt gebruik van SMTP
- [ ] Mailserver maakt gebruik van IMAP
- [ ] Mails kunnen intern naar elkaar vestuurd en ontvangen worden (via twee workstations)
- [ ] Alle gebruikes van alfa 1 hebben hun eigen mailbox
- [ ] Mailserver past anti-spam en anti-virus technieken toe
- [ ] Mails kunnen verstuurd worden tussen green.local en red.local

### Echo 1
- [ ] Webserver is toegankelijk via HTTP en HTTPS
- [ ] Webserver maakt gebruik van Drupal
- [ ] Heeft verbinding met November 1 voor de databank
- [ ] Kan de website bereiken door te surfen naar 'https://www.green.local' via workstation uit green.local
- [ ] Kan de website bereiken door te surfen naar 'https://www.green.local' via workstation uit red.local

### Kilo 1
- [ ] Gekende workstations krijgen een IP-adres gereserveerd op MAC-adres
- [ ] DHCP deelt IP adres uit aan niet-gekende workstations

### Lima 1
- [ ] Fileserver is aanspreekbaar via SMB/CIFS
- [ ] De server is geïntegreerd in de directory structuur gedefinieerd door alfa1
- [ ] Elke gebruiker heeft een homefolder
- [ ] Elke gebruiker kan zijn homefolder bekijken en bewerken
- [ ] De homefolder van een gebruikers is afgeschermd voor andere gebruikers

### Mike 1
- [ ] Heeft verbinding met November 1 voor de databank
- [ ] Server is enkel toegankelijk voor interne gebruikers van het domein green.local

### November 1
- [ ] Maakt gebruik van MariaDB
- [ ] Bevat de databank voor echo1
- [ ] Bevat de databank voor mike1

### Oscar 1
- [ ] Toestand van het gehele netwerk + services kan visueel worden voorgesteld via Kibana webinterface
  - [ ] Cisco routers & switches
    - [ ] CPU-gebruik
    - [ ] Geheugengebruik
    - [ ] Inkomend verkeer op alle netwerkpoorten
    - [ ] Uitgaand verkeer op alle netwerkpoorten
  - [ ] Servers
    - [ ] CPU-gebruik
    - [ ] Geheugengebruik
    - [ ] Toestand van harde schijven
    - [ ] Toestand van de specifieke service die op de machine draait
  - [ ] werkstations
    - [ ] CPU-gebruik
    - [ ] Geheugengebruik
    - [ ] Toestand van harde schijven
    - [ ] Gebruikerslogins
- [ ] Monitoring is toegankelijk door te surfen naar 'https://mon.green.local'

### Papa 1
- [ ] Het is mogelijk hosts via het netwerk te installeren die meteen kunnen ingezet worden

### Quebec 1
- [ ] DNS-requests worden geforward naar de juist DNS afhankelijk van het domein


### Werkstations

- [ ] Er zijn 5 werkstations aanwezig
  - [ ] één in IT-Administratie
  - [ ] één in Ontwikkeling
  - [ ] één in Verkoop
  - [ ] één in Administratie
  - [ ] één in Directie


## Criteria gradaties services

### Bekwaam

- [ ] Routering tussen beide netwerken werkt volledig
- [ ] DNS is beschikbaar
- [ ] Werkstation krijgen correcte IP-instellingen
- [ ] Er is een planning
- [ ] Grotendeels geautomatiseerd

### Gevorderd

- [ ] Integratie van alle gerealiseerde netwerkdiensten binnen het eigen netwerk
- [ ] Alle netwerkdiensten zijn bereikbaar vanop elk workstation
- [ ] Het in productie brengen van het netwerk op de eindevaluatie gebeurt aan de hand van vooraf uitgeschreven procedures

### Deskundig

- [ ] Integratie van alle gerealiseerde netwerkdiensten over beide netwerken heen (bv. e-mail) is geslaagd
