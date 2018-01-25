# Testplan : Quebec1 DNS forwarder

**Opsteller testplan:** Pim Lefevere

Dit testplan zal de werking van de DNS forwarder testen, zijnde `quebec1`.

Checklist

- [ ] Opstarten slaagt en start op zonder errors.
- [ ] DNS servers worden correct weergegeven voor zowel `green.local` als `red.local`.

## Test 1 - Opzetten VM's:

1. Ga vanop de host-machine naar de lokale working directory van het project.
2. Voer het volgende commando uit: `vagrant status`

    - Er zou vervolgens een lijst van virtuele machines moeten getoond worden. Daar zouden 'bravo1' en 'quebec1' de status `not created` moeten hebben. Indien dit niet het geval is, voer het commando `vagrant destroy -f bravo1 quebec1`
3. Start vervolgens de DNS-servers op met het commando `vagrant up bravo1 quebec1`. (Nodige roles dienen geïnstalleerd te zijn)
    - Verwacht resultaat is dat dit uitvoert zonder errors.

## Test 2 - DNS forwarder testen
1. Typ op het hostsysteem het commando `vagrant ssh quebec1`
2. Test of de juiste DNS-servers worden doorgegeven voor 'green.local' met het commando `dig NS green.local @localhost +short`
	- 'bravo1.green.local' & 'charlie1.green.local' moeten opkomen.
3. Voer hetzelfde commando nu uit maar dan voor red.local. `dig NS red.local @localhost +short`
	- Na uitvoer van dit commando volgt er `time out; no servers could be reached`. Oorzaak hiervan: geen aangesloten servers van red.local. Dit kan pas verder getest worden eens green.local en red.local worden verbonden.
