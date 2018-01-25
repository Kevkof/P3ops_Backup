## Technische documentatie Netwerken

**Opsteller van deze documentatie: Thomas Valcke**

### Het opstellen en configureren van een Pfsense firewall
*Deze documentatie gaat ervan uit dat u basis begrippen van shell commando's en algemene netwerk configuratie beheerst*
#### Fysieke opstelling
Requirements
- ISO file met pfsense
- Een host machine met minimum 2 netwerk kaarten
Opstelling
- Stel een usb in als boot device en zet de ISO er op
- Run de standaard configuratie

#### Configuratie firewall
Via de web terminal kan u alle traffic (zowel inkomend als buitengaand) reguleren
<br>
Ga als volgend in de web cliënt naar ` Firewall`  tab -> ` rules `
Dan krijg je twee tabs, de Lan en de Wan die voor ons belangrijk zijn.
De (WAN) is het traffic die naar buiten gaat hier mogen we in principe afblijven. Voor binnen komende ( naar de LAN ) moeten we verschillende regels instellen.
<br>
- VB rule SSH 
    - Een rule toevoegen: Selecteer ` add `
    - Action: Selecteer ` Pass ` ( deze rule zal dus toelaten )
    - Protocol: ` TCP ` ( dit is het protocol gebruikt voor SSH)
    - Source: ` LAN net ` ( voor al de machines op de subnet )
    - Destination port: ` Other,  22 `
<br>
Nu voor onze andere services 
<br>
- Alfa1: LDAP
    - Ports: 389/TCP | *636/TCP (SSL)*  
    - Eventueel: 3268/TCP | *3269/TCP (SSL)*
- Bravo1: Authorative-Only DNS
    - Ports: 53 UDP & TCP
- Charlie1: Slave DNS
    - Ports: 53 UDP & TCP
- Delta1: Mailserver (SMTP & IMAP)
    - SMTP Ports: 25/TCP | 465/TCP (Secure)  
    - IMAP Ports: 143/TCP | 993/TCP (Secure)
- Echo1: Webserver (HTTP/HTTPS/DRUPAL)
    - Ports: 80/TCP | 443/TCP
<br>


#### Automatiseren
Het automatiseren van een pfsense firewall is zeer basic, er zijn geen commando's of scripts om deze taak over te nemen maar alles word bewaart in de config.xml file.
De beste manier om deze te automatiseren is een clean install uitvoeren op een werkende fysieke machine met twee netwerkkaarten. 
Dan de config.xml van die nieuwe machine vervangen met een alreeds geconfigureerde config.xml
Om de file op de nieuwe machine te krijgen is iets onhandiger. Ga naar de shell en installeer git
` pkg install git `
dan clone van onze repository met de config.xml
` Clone https://github.com/HoGentTIN/p3ops-green/blob/master/doc/netwerk/firewall/config.xml `
u kan de nieuwe config nu veranderen met de gepreconfigureerde config.xml
` mv /pfsenseconfig/config.xml /cf/conf/ `
Nu herstart u best de pfsense machine en staat deze klaar voor binnen het netwerk geplaatst te worden.

### Troubleshooting
Indien uw netwerk traffic hinder ondervind raden we u de volgende stappen te door lopen om zo snel mogelijk vast te stellen waar het probleem zich bevind.
- Ga naar de pfesense box en laat alle traffic zowel binnenkomend als uitgaand toe om zeker zijn dat niets geblokkeerd word en valse resultaten oplevert via de web terminal.
- Zijn de 2 kabels tussen uw netwerk en uw pfsense opstelling verbonden en werken deze ?
- Ping van Netwerk gateway naar pfsense opstelling en omgekeerd, werkt dit ? (commando: `ping x.x.x.x` waarbij x uw ip address is)
- Als u tot hier toe nog geen probleem hebt gevonden ligt het probleem waarschijnlijk bij uw netwerk configuratie.
