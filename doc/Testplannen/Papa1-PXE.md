# Testplan : papa1 PXE Server

**Opsteller(s) testplan**: `Jodie De Pestel`, `Kevin Verlinde`

- [ ] Opstarten slaagt en start op zonder errors
- [ ] Workstation opzetten via het netwerk
- [ ] Server opzetten via het netwerk

## Test 1 - opstarten VM:

1. Ga vanop de host-machine naar de map met de vagrantfile van het project via de command-line.
2. Als je je in de map bevindt, typ het volgende commando om te controleren of de vm's al dan niet zijn aangemaakt.
3. Maak gebruik van het commando: `vagrant status`.

* Hier krijg je een lijst van machines met hun status, de vm papa1 zou "not created" moeten zijn, als dit niet zo is voer je het commando `vagrant destroy -f papa1` uit
* Voor het aanmaken van de vm papa1 typ je het volgende commando: `vagrant up papa1`

* Verwachte resultaten:
    - Via de GUI van VirtualBox zien we de vm papa1 draaien
    - De laatste uitvoerlijn op de commandline heeft volgende uitvoer

Zonder kickstart files
```
PLAY RECAP *********************************************************************
papa1                      : ok=64   changed=44   unreachable=0    failed=0
```

## Test 2 - Workstation opzetten via het netwerk (zonder kickstart).

1. Om te kijken of de PXE-server wel daadwerkelijk werkt zet je best een nieuwe VM op.
* Vereisten VM:
  * OSType: Other Linux(64bit)/Fedora (64bit)
  * Ram: min. 2 GB
  * HDD: min. 12 GB
  * Netwerk: Zelfde hostonly adapter als de papa1 vm (netwerk_ip: 172.16.0.0, netmask: 255.255.0.0)
  * Boot options:
    * [x] Hard Drive
    * [x] Network
* Overige vereisten:
  * kilo1 is up and running
  * papa1 is up and running
2. Als dit gebeurt is dan moet je er voorzorgen dat je via het netwerk opstart, dit doe je door op F12 te klikken. Hierna hoef je niks meer te doen en installeerd de workstation vanzelf.
3. Dit process is succesvol wanneer de VM 'eindigt' op het installatie scherm van Fedora 27

![Fedora install](https://i.imgur.com/fT4ZVt2.png)

## Test 3 - Server opzetten via het netwerk (zonder kickstart).
1. Om te kijken of de PXE-server wel daadwerkelijk werkt zet je best een nieuwe VM op.
* Vereisten VM:
  * OSType: Other Linux(64bit)
  * Ram: min. 2 GB
  * HDD: min. 12 GB
  * Netwerk: Zelfde hostonly adapter als de papa1 vm (netwerk_ip: 172.16.0.0, netmask: 255.255.0.0)
  * Boot options:
    * [x] Hard Drive
    * [x] Network
* Overige vereisten:
  * kilo1 is up and running
  * papa1 is up and running
2. Als dit gebeurt is dan moet je er voorzorgen dat je via het netwerk opstart, dit doe je door op F12 te klikken. Hierna hoef je niks meer te doen en installeerd de workstation vanzelf.
3. Dit process is succesvol wanneer de VM 'eindigt' op het installatie scherm van Centos 7

![Centos install](https://i.imgur.com/NBn6vNr.png)
