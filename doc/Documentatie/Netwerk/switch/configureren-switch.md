## Technische documentatie Netwerken

### Het configureren van een switch
*Deze documentatie gaat ervan uit dat u in een netwerk te werk gaat waar meerdere VLANS in gebruik zijn.*<br>
#### Algemeen

De eerste belangrijke  stap die dient genomen te worden bij het configureren  van een switch in het netwerk is het aanmaken van de `VLAN's`.
```
enable
conf t
vlan X
vlan Y
vlan Z
.
.
.
```
Hier met `X,Y en Z` de gewenste `VLAN's`.
Een hostname kan ook toegekend worden voor een duidelijkere werkomgeving.
```
enable
conf t
hostname HOSTNAME
```
Ook ( indien van toepassing )het configureren  van een `management VLAN` dient op elke switch te gebeuren.  Een `management VLAN` is simpelweg een vlan waar u een `IP-adres` aan toewijst
```
enable
conf t
int vlan 99
ip add IP SUBMASK
no sh
```
Hier werd ``vlan 99`` gebruikt omdat dit het meest frequent is.
#### Interface configuration
Het configureren van de interfaces is tot op een bepaald niveau steeds hetzelfde. Uiteraard zullen de specifieke poorten verschillen.<br>
Eerst bepaalt u of uw switch een link heeft die als `trunk`<sup>(1)</sup> moet functioneren. Indien dit niet het geval is stelt u de nodige poorten in als `access ports`. Ook voert u uiteraard het `no shutdown` commando uit zodanig de interface `UP` is.
```
enable
conf t
int INT
switchport mode access
switchport access vlan X
no sh
.
.
.
```
Hier is `X` de `VLAN` die actief is op de verbinding aan interface `INT`.<br>
Indien u wel met een `trunk link` <sup>(1)</sup> moet werken dan dient u op deze interface `mode trunk` te specifiëren.
```
enable
conf t
int INT
switchport mode trunk
switchport trunk allowed vlan X,Y,Z
no sh
.
.
.
```
Hier zijn `X,Y en Z` de `VLAN's` die worden toegelaten op de `trunk link` in interface `INT`.

### Troubleshooting
Indien er problemen zijn in uw netwerk en u denk dat deze komen door de configuratie van uw switches overloopt uw volgende lijst:
- Werden alle `VLAN's` op elke switch aangemaakt (dit gebeurd door het uitvoeren van het ``vlan X`` commando)
- Zijn de nodige poorten `UP` (`no sh` commando)
- Werden alle poorten correct als `access` of `trunk` ingesteld
-



### Notes
<sup>(1)</sup> Een `trunk link `is een link waar packets van verschillende `VLANS` over vervoerd moeten worden. Een packet over een `access link` krijgt geen segment waar de vlan in wordt gespecifieerd. Een packet dat over een ``trunk link`` wordt gestuurd krijgt dit echter wel, zo blijft duidelijk welke packets van welke `` VLAN's`` afkomstig zijn.
