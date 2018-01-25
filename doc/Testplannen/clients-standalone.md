# Testplan : papa1 PXE Server

**Opsteller(s) testplan**: `Tim Caudron`

- [ ] Workstation opzetten via het netwerk

##prerequisites
zorg dat je de laatste versie hebt van 

- kilo1
- papa1

eventueel moet er `Vagrant destroy -f kilo1 papa1` gedaan worden.

vervolgens `vagrant up kilo1 papa1`

## Test - Workstation opzetten via het netwerk .

1. Om een test met de kisckstart te starten zet je een nieuwe VM op.
* Vereisten VM:
  * OSType: Other Linux(64bit)/Fedora (64bit)
  * Ram: min. 4 GB
  * HDD: min. 20 GB
  * Netwerk: Zelfde hostonly adapter als de papa1 vm (netwerk_ip: 172.16.0.0, netmask: 255.255.0.0)
  bijkomende nat adapter voor het downloaden van het netwerk
  * Boot options:
    * [x] Hard Drive
    * [x] Network
* Overige vereisten:
  * kilo1 is up and running
  * papa1 is up and running
* Als dit gebeurt is dan moet je er voorzorgen dat je via het netwerk opstart, dit doe je door op F12 te klikken. Hierna hoef je niks meer te doen en installeerd de workstation vanzelf.
* Deze installatie is succesvol wanneer de VM 'eindigt' met de installatie en vraagt van te herstarten.
* Log in met password `password` en de VM is klaar voor gebruik.


