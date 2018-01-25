## Technische documentatie Netwerken

### Het configureren van een router
*Deze documentatie gaat ervan uit dat u in een netwerk te werk gaat waar meerdere VLANS in gebruik zijn.*<br>
#### Interface configuration
##### Geen interVlan routing
Indien u een router configureert waar geen packets over verschillende `VLAN's` dienen verstuurd te worden (``interVlan routing``), dan blijft het werk redelijk simpel.
Begin met toewijzen van `IP-adressen` aan al de nodige interfaces
```
enable
conf t
int INT
ip ad IP SUBMASK
no sh
.
.
.
```
Herhaal deze procedure voor elke interface.<br>
Indien u een interface heeft die een `IP-adres` dient toegewezen te worden van de DHCP server, dan gaat u als volgt te werk:
```
enable
conf t
int INT
ip ad DHCP
no sh
.
.
.
```
#### interVlan routing
Indien u een router configureert die packets over meerdere `VLAN's` dient te routeren, dan configureert u `router-on-a-stick` <sup>(1)</sup>.
```
enable
conf t
int INT.VLAN
encapsulation dot1q VLAN
ip ad IP SUBMASK
.
.
.
int INT
no sh
```
De gekozen interface `INT` kan bijvoorbeeld `g0/0` zijn. Dan stelt u de subinterfaces in als `g0/0.30` voor bijvoorbeeld ``VLAN 30``. U hoeft niet hetzelfde getal te gebruiken maar dit is de `standard practice` en zorgt ook voor duidelijkheid binnenin uw netwerk.

#### Routes
Het instellen van routes is vaak ook nodig. Er zijn meerdere soorten routes en er zijn meerdere manieren om routes te configureren. De manier die we toepassen in het project is de `exit-interface` methode. Een andere methode is de `Gateway IP`methode. Simpel uitgelegd, wij definiëren uit welke interface een route moet vertrekken terwijl de andere methode definieert naar welke `next-hop` de route gaat. <br>Het configureren van een route is uiterst simpel.
```
enable
conf t
ip route IP_DEST SUBMASK_DEST EXIT_INT
.
.
.
```
`IP_DEST` is het `IP-adres` naar waar de route gaat, de `EXIT_INT` is de interface via waar de route de router verlaat. <br>

Vaak is het ook gewenst om een `Default route` in te stellen. Dit is een route via waar al het verkeer wordt gestuurd dat geen gekend doel heeft.
```
enable
conf t
ip route 0.0.0.0 0.0.0.0 EXIT_INT
```
`0.0.0.0 0.0.0.0` is een `IP-adres` met een mask die alle `ip-adressen` omvat. Specifiekere routes worden altijd geprefereerd. Zo zullen enkel de packets met een ``dest_ip`` dat niet door een andere route gespecifieerd wordt via deze route verzonden worden.
#### NAT <sup>(3)</sup>
Indien u NAT wilt implementeren voor uw netwerk toegang te verlenen naar de buitenwereld gebruik makend van translations, dan gaat u als volgt te werk.
NAT configureert u op de router die het acces-point vormt naar uw netwerk. Daar onderneemt u verschillende stappen.<br>
*We gaan er van uit dat IP adressering en dergelijke al is toegepast op uw interfaces door het overlopen van de vorige stappen*<br>
U kiest welke interfaces  `Inside` interfaces worden en welke `outside` interfaces worden.
  - Een `Inside` interface is de interface die verbonden is met uw intern netwerk

```
enable
conf t
int INT
ip nat enable
ip nat inside
exit

```
  - Een `Outside` interface is de / zijn de interface(s) die verbonden zijn met andere netwerken.

```
enable
int INT
ip nat enable
ip nat outside
exit

```
Vervolgens definieert u een `access-list` die bepaalt welke inside adressen er mogen vertaald worden.
Hier zijn meerdere opties mogelijk.
Ten eerste kunt u te werk gaan met een  `standard access-list` waar u met 1 commando een nummer (NR) ingeeft als naam voor de `access-list` en een network adres voor de adressen die mogen vertaald worden.
```
enable
conf t
access-list NR permit IP SUB
```
`IP` en `SUB` kunt u vervangen door `any any` indien u geen specifiek netwerk wenst te definiëren. Met deze instelling kunnen nu alle IP-adressen vertaald worden die hierom vragen. (Kan soms niet goed zijn voor veiligheid  redenen) <br>
Indien u verschillende adressen wilt toevoegen aan uw ``ACL`` dan kunt u ook als volgt te werk gaan
```
enable
conf t
ip access-list standard NAME
NR permit  IP
NR permit  IP
.
.
.

exit
```
Ook hier kunt u `IP` vervangen door `any`.
`NR` is de nummering voor het plaatsen van uw regel in de `access-list`. Als u hier bijvoorbeeld 25 ingeeft zal deze na een regel komen met nummer 18 bv. maar voor een regel met nummer 30. Dit is optioneel, als u nooit nummers meegeeft zullen de lijnen telkens onderaan ingevoerd worden. Als twee lijnen betrekking hebben op dezelfde soort traffic dan wordt de laatste lijn toegepast.
NAME is de naam die u wenst voor uw `ACL` (in de voorgaande methode staat dit gelijk aan ``NR``)
<br>
<br>
Vervolgens kunt u (optioneel) een `extended access-list` aanmaken voor te bepalen welke adressen er al dan niet door een bepaalde interface mogen. Dit heeft niets te maken met `NAT` maar kan een extra beveiliging vormen.
```
enable
conf t
ip access-list extended NAME
permit TYPE IP SUB (established)
permit TYPE IP SUB
```
Ook hier kunt u `IP` & `SUB` vervangen door `any any`.
`TYPE` kan van alles zijn, gebruik `?` voor alle mogelijke opties. Wij gebruiken `tcp` en `ip`.
Het `established` keyword wijst erop dat enkel packets waar de `ACK` bit in de  `TCP HEADER` aan staat door mogen. Dit toont dat een `three-way handshake` is voltooid.<sup>(4)</sup>
Deze `ACL` dient u toe te passen op een interface door volgend commando:
```
enable
conf t
int INT
ip access-group NAME {in | out}
```
De `in | out` keywords bepalen of deze `ACL` toegepast wordt op binnenkomend of uitgaand verkeer.
<br>
<br>
Indien u GEEN gebruik maakt van `Port Address Translation (PAT)`<sup>(6)</sup> (maw. u beschikt over meerdere `ip adressen` die kunnen dienen als `Inside  global address` <sup>(5)</sup>) dan dient u deze te definiëren  in een `pool`.
```
enable
conf t
ip nat pool NAME START-IP END-IP {netmask SUB | prefix-length CIDR}
```
Waar:
- `NAME` = de naam van uw pool
- `START-IP` & `END-IP` de range van uw `Inside  global adresses` definieert
- `SUB` of `CIDR` de subnetmask of de prefix-length van uw range definieert
Hierna kunt u volgend commando uitvoeren:

```
enable
conf t
ip nat inside source list NR pool NAME (overload)
```
Met `NR` het nummer of de naam van uw `standard-ACL`. En `NAME` de naam van uw pool.
Het `overload` keyword bepaald of meerdere adressen uit de `ACL` mogen vertaald worden op hetzelfde `IP` uit de `pool`.
Na het uitvoeren van dit commando zullen alle packets die naar buiten willen eerst gefilterd  worden door de `ACL` en dan vertaald worden naar een adres uit de `pool`.

<br>
Indien u WEL gebruik maakt van `Port Address Translation (PAT)`dan hoeft u geen `pool` te definiëren. (Dit is nog steeds een optie! Uw `pool` zal dan echter maar uit 1 adres bestaan)
U kunt nu onmiddellijk volgend commando uitvoeren:
```
enable
conf t
ip nat inside source list NAME interface INT overload
```
Hier is `NAME` de naam van de `standard-ACL`.
`INT` is de` outside interface` die het `IP address` heeft dat u wenst te gebruiken om naar buiten te gaan. Dit is handiger dan het gebruiken van een `pool` met 1 `IP` in indien uw `outside interface` een `IP` krijgt van een `DHCP server`. Zo blijft uw `NAT` steeds functioneel ook als het `IP` van uw interface veranderd.
Het `overload` keyword zorgt ervoor dat meerdere `inside local addresses` zullen vertaald worden naar hetzelfe `inside global address`.
Indien u toch wenst gebruik te maken van een `pool` dan gaat u identiek te werk als bovenstaande methode.

#### DHCP
Als u een subnet heeft waar de clients een `IP` diennen toegewezen te worden via een `DHCP` dan moet u volgend commando uitvoeren:

```
enable
conf t
int INT
ip helper-address IP

```
Hier is `INT` de interface waar de  Broadcasts van de clients aankomen. In ons netwerk is dit `F0/1.20` op `routerIn`.
`IP` is het `IP address` van de `DHCP` server.
Deze configuratie moet op de eerste router gebeuren dat uw `broadcast` tegenkomt.
Erna is de `broadcast` een `unicast` en zal deze dus door de volgende routers normaal gerouteerd worden.

### Troubleshooting
Indien u op problemen stuikt die waarschijnlijk te maken hebben met de configuratie van uw routers kunt u volgende zaken controleren:
- Werden alle interfaces in de state `UP` geplaatst? (commando: `no sh`)
- Werden alle interfaces een geldig IP toegekend? (commando: ``IP ADDRESS``)
- Werkt uw DHCP correct zodanig interfaces die een IP van de DHCP dienen te ontvangen wel degelijk functioneren?
- Werden op alle subinterfaces de correcte `VLAN's` toegewezen? (commando: `encapsulation dot1q VLAN`)
- Werd er een correcte default route ingesteld? Correcte `EXIT_INT`/ correct IP
- Werden de andere routes correct geconfigureerd? `do show ip route`
- Zijn al de ingestelde ACL's correct? `do show access-lists`
- Is NAT correct geconfigureerd? `do show ip nat statistics`



### Notes
<sup>(1)</sup> `router-on-a-stick` is het opdelen van 1 fysieke interface in meerdere virtuele interfaces (subinterfaces). Elke virtuele interface wordt dan toegewezen aan een specifiek ``VLAN``. En enkel verkeer voor dat ``VLAN`` zal via deze interface vertrekken/aankomen.
<sup>(2)</sup><https://www.cisco.com/c/en/us/td/docs/security/asa/asa82/configuration/guide/config/route_static.html>
<sup>(3)</sup> <https://www.cisco.com/c/en/us/td/docs/ios-xml/ios/ipaddr_nat/configuration/15-mt/nat-15-mt-book/iadnat-addr-consv.html>
<sup>(4)</sup> (The established keyword indicates that packets belong to an existing connection if the Transmission Control Protocol (TCP) datagram has the Acknowledgment (ACK) or Reset (RST) bit set.)
<sup>(5)</sup>) ( A legitimate IP address assigned by the NIC or service provider that represents one or more inside local IP addresses to the outside world. ) <https://www.cisco.com/c/en/us/support/docs/ip/network-address-translation-nat/4606-8.html>
<sup>(6)</sup> <http://www.freeccnastudyguide.com/study-guides/ccna/ch10/10-4-nat-overloading-aka-port-address-translation-pat/>
