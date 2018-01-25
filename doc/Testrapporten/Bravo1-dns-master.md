# Testrapport: DNS Master

Commando uitgevoerd:

```
$ sudo /vagrant/tests/runbats.sh
```

Uitvoer:

```
Running test /vagrant/tests/bravo1/masterdns.bats
 ✓ Het `dig` commando zou moeten geïnstalleerd zijn.
 ✓ Het hoofdconfiguratiebestand named.conf zou syntactisch correct moeten zijn.
 ✓ De forward zone bestand zou syntactisch correct moeten zijn.
 ✓ Het reverse zone bestand zou syntactisch correct moeten zijn.
 ✓ De service zou moeten draaien.
 ✓ Forward lookups van publieke servers uit VLAN 50.
 ✓ Forward lookups van interne servers uit VLAN 30.
 ✓ Reverse lookups van publieke servers uit VLAN 50.
 ✓ Reverse lookups van interne servers uit VLAN 30.
 ✓ Alias lookups public van publieke servers in VLAN 30.
 ✓ Alias lookups private servers uit VLAN 50.

11 tests, 0 failures
```

Alle tests zijn geslaagd.

## Testinfo

Uitvoerder(s) test: Lander Van den Bulcke
Uitgevoerd op: 23/10/2017
