# Verslag voicechat

- Datum : 02/11/2017
- Begin : 17:18
- Einde : 18:25
- Locatie: Via skype na rondvraag op Slack
- Notulist:  [Robbe Devos](https://github.com/devosrobbe)

## Aanwezigen tijdens het gesprek

**Team Aalst**
- [Pieter-Jan Philips](https://github.com/dhrpieterjan)
- [Robbe Devos](https://github.com/devosrobbe)

**Team Gent**
- [Brecht Claeys](https://github.com/BrechtClaeys)
- [Gianni Van Havermaet](https://github.com/GianniVanHavermaet)
- [David Gooskens](https://github.com/DavidGooskens)
- [Jodie De Pestel ](https://github.com/JodieDePestel )
- [Kevin Verlinde](https://github.com/KevinVerlinde)
- [Kjell	Vianene](https://github.com/kjviaene)
- [Lander	Van Den Bulcke](https://github.com/landervdb)
- [Ruben Bruggeman](https://github.com/RubenBruggeman)
- [Tim Caudron](https://github.com/TimCaudron)

## Doel
Het doel van de voice chat was om verschillende onderwerpen te bespreken.

## Besproken onderwerpen
De onderwerpen zijn in volgorde zoals ze aan bod zijn gekomen tijden het voice gesprek.

### 1. Alfa1 - LDAP server
Er werd gevraagd vanuit Aalst of de LDAP server volledig klaar is, aangezien Mike1(Aalst) de LDAP server nodig heeft voor verdere configuratie. De vertegenwoordiger van de LDAP server heeft gemeld dat er nog een aantal problemen zijn met de LDAP server i.v.m. de credentials. Ze gaan dit zo snel mogelijk onderzoeken en aanpassen. Aalst zal op de hoogte gebracht worden wanneer de LDAP server klaar is.

### 2. Branching
Er werd opgemerkt dat de branches van Mike1 en November1 heel wat achter zitten op de master. Aalst meldde hierbij het volgende :
- De Mike1 branch staat on hold zolang dat LDAP server niet volledig werkt. De reeds gecommite versie op de master is al een volledig werkende Mike1 server zonder integratie van LDAP.
- De November1 branch wordt gebruikt om het testplan en testverslag te schrijven. Hierbij werd er opgemerkt dat de naamgeving van de branch November1 anders moet. vb, November1/testen. De reeds gecommite versie op de master is een volledig werkende November1

### 3. Bravo1 - DNS server
De vertegenwoordiger van Echo1 vroeg of de DNS server al werkte aangezien Echo1 bereikbaar moet zijn via het www voorvoegsel. Hierbij werd er gemeld dat de DNS server volledig werkende is.

### 4. Deployment
Uit Aalst werd er de vraag gesteld hoe de deployment er zal uitzien. Gent meldde hierbij dat ze verschillende machines met CentOS en KVM zouden gebruiken. Verdere informatie over de deployment zal nog worden meegedeeld.

### 5. Delta1 - mailserver
Aalst stelde voor om de installatie en configuratie van Delta1 tot zijn rekening te nemen aangezien alle server van Aalst allemaal bijna af zijn. Gent ging hier mee akkoord.

### 6. IP Adressering
De vraag was hoe de ip-adressering ging gebeuren aangezien er bij de deployment niet met vagrant zal gewerkt worden. Hierover zal er nog worden gecommuniceerd.

### 7. Commiten van ansible rollen op github
Aangezien anisble rollen niet worden meegecommit werd er de vraag gesteld hoe je aangepaste rollen wel kunt commiten. Hierbij werd er gemeld dat je de naam van de rol moest veranderen -> bertvv.samba wordt samba.

### 8. Analyse
- Er was opgemerkt dat er een aantal personen niet met hun githubaccount aangemeld zijn op hun gitbash. Deze personen zullen worden gecontacteerd met de vraag om zich aan te melden op hun gitbash vooraleer ze pushen op github.
- Uit het analyse gesprek van Gent werd er geconcludeerd dat Aalst minder uren heeft gewerkt dan Gent. We zijn tot de gezamelijke conclusie gekomen dat dit komt door de moeilijkheidsgraad van de verschillende servers.
- Uit het analyse gesprek van Gent bleek ook dat nog niet iedereen gepusht heeft op github. Dit komt doordat er verschillende mensen samenwerken op 1 computer. Hierdoor is de eigenaar van de computer meestal diegene die pusht op de server. Gent en Aalst hebben afgesproken dat er meer rekening mee zal gehouden worden wie er pusht op github
- Gent melde dat er tijdens de deployment op 6/11/2017 een extra kanbanbord zal gemaakt worden waarbij  de vooruitgang van de deployment tezien zal zijn.

### 9. Monotoring
Aalst vroeg of ze iets moesten toevoegen aan de installatie van hun server om het Monotoring systeem te laten werken. De vertegenwoordiger van de monotoring heeft gemeld dat dit allemaal gebeurt door de personen van monotoring.

### 10. Papa1 - PXEBoot server
De vertegenwoordiger van de Papa1 server vroeg of Aalst eventueel bereid was om te helpen met de PXEBoot server. Aalst heeft hier positief op geantwoord. Er zal nog verder worden gecommuniceerd wanneer Aalst hierbij zal helpen.


## Reflectie

De voicechat is zeer goed verlopen. Iedereen heeft zijn vragen kunnen stellen en heeft inbreng gehad op de verschillende onderwerpen.
