## Technische documentatie Netwerken
### Het fysiek opzetten van de netwerkapparatuur
#### Hardware benodigdheden
 * 2 Routers (met elk min 2 `Fast Ethernet` poorten)
 * 3 Switchen (Met elk min 2 `Gigabit Ethernet` poorten en 16 `Fast Ethernet` poorten)
 * 1 Desktop met 2 werkende netwerkkaarten en zonder besturingssysteem
 * 1 Desktop met `PuTTy` geïnstalleerd
 * 2 Monitors (1 voor configuratie firewall & 1 voor configuratie netwerkapparatuur)
 * 1 Console kabel
 * 9 stroomkabels (5 voor netwerkapparatuur, 2 voor de desktops, 2 voor de monitors )
 * 1 Ethernet kabel die internettoegang verschaft (enkel indien geen verbinding met windows team)
 * 2 `Cross-over` kabels
 * 3 Korte Standaard ethernet kabels
 * 4 Lange standaard ethernet kabels (5 Indien connectie met windows team)
 * 1 USB-Stick met configuratie bestanden
 * 1 `bootable USB` voor pfsense

#### Opzetten Hardware
* Verbindt een router met het internet. Dit via een internetverbinding van school of via de algemene routers van het project als deze geconfigureerd zijn. Dit is `Router0`. Gebruik hiervoor poort `F0/1`.
* Connecteer `Router0` via `F0/0` met de Desktop zonder besturingssysteem (de `Firewall`)
* Connecteer nu de andere router via `F0/0` met de andere netwerkkaart van de `Firewall`. Dit is `RouterIn`.
* Connecteer `RouterIn` via `F0/1` met een switch in poort `F0/1`. Dit is `Switch1 L2`.
* Connecteer `Switch1 L2` via `G0/1` met `G0/2` van de tweede switch. Dit is `Switch2 L2`.
* Connecteer `Switch2 L2` via `G0/2` met `G0/2` van de laatste switch. Dit is `Switch3 L2`.
* Nu zou u volgende structuur moeten hebben:
  * `R0 - F - RIn - S1 - S2 - S3`
  * Het is ook het eenvoudigst dat u de apparatuur ook in deze volgorde stapelt zodanig geen verwarring ontstaat. (Buiten de `firewall` die uiteraard naast uw routers en switches staat)

#### Configureren Firewall
* Installeer `pfsense` via de usb met een `.iso` voor `pfsense`.
* Configureer de `config.xml` file zoals beschreven in de subsection `automatiseren` in  [firewall-pfsense.md ](firewall/firewall-pfsense.md) in de map `firewall`.
* Controleer of uw connectie met `Router0` wel degelijk in de `WAN` kaart zet in respectievelijk de connectie met `RouterIn` in de `LAN` kaart zit.

#### Configureren netwerkapparatuur
* Reset alle switches door de knop `mode` ingedrukt te houden tot de lampjes oranje kleuren.
* Connecteer een desktop met `PuTTy` geïnstalleerd via een consolekabel met `Router0`.
* Open een `Serial` verbinding in `PuTTy`
* Reset de router door volgende commando's uit te voeren:
```
router> enable
router# write erase
Erasing the nvram filesystem will remove all configuration files! Continue? [confirm] <Press Enter key>
router# reload
Proceed with reload? [confirm] <Press Enter key>
-OR-
Would you like to enter the initial configuration dialog? [yes|no] no <Press Enter key>
–OR–
Do you want to save the configuration of the AP? [yes|no] no <Press Enter key>
```
* Open de file met als naam `router0.md` die zich op de USB moet bevinden met de configuratie bestanden.
* Kopieer alles in het bestand (buiten de `markdown `symbolen ) inclusief een enter na het laatste commando.
* Kopieer dit in uw console van `router0` (rechtermuisknop). Dit zorgt ervoor dat alle commando's uitgevoerd worden.
* Connecteer uw console kabel in het volgend netwerkapparaat en ga op identieke wijze te werk. (Bij `RouterIn` dient u opnieuw eerst te resetten, terwijl deze reset kunt u al da switchen configureren).

#### Opzetten netwerk
* Alle servers die zich in `VLAN50` bevinden dienen geconnecteerd te worden met `Switch1 L2` via `F0/2-24`
* Alle servers die zich in `VLAN30` bevinden dienen geconnecteerd te worden met `Switch2 L2` via `F0/1-24`
* Alle clients die zich in `VLAN20` bevinden dienen geconnecteerd te worden met `Switch3 L2` via `F0/1-24`

#### Troubleshooting
* Controleer of bij elke verbinding de correcte Led’s branden op het corresponderende toestel.
* Controleer dat de kabels zich in de juiste poorten bevinden.
* Controleer of de kabels goed werken. (Een connectie die maar voor 50% werkt kan al genoeg zijn om pings te doen mislukken)
* Check of de juiste configuraties werden uitgevoerd op de juiste appratuur. (Dat bijvoorbeeld S2 niet op de plaats van S3 staat en omgekeerd)
