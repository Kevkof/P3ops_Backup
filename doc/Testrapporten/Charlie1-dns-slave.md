# Testrapport: DNS Slave

Commando uitgevoerd:

```
$ sudo /vagrant/tests/runbats.sh
```

Uitvoer:

```
Running test /vagrant/tests/charlie1/slavedns.bats
 ✓ Het `dig` commando zou moeten geïnstalleerd zijn.
 ✓ Het hoofdconfiguratiebestand named.conf zou syntactisch correct moeten zijn.
 ✓ De server zou moeten ingesteld zijn als slave.
 ✓ De server zou requests moeten forwarden naar de master server.
 ✓ Er zou geen forward zone bestand mogen zijn.
 ✓ De service zou moeten draaien.
 ✓ Forward lookups van publieke servers uit VLAN 50.
 ✓ Forward lookups van interne servers uit VLAN 30.
 ✓ Reverse lookups van publieke servers uit VLAN 50.
 ✓ Reverse lookups van interne servers uit VLAN 30.
 ✓ Alias lookups public van publieke servers in VLAN 30.
 ✓ Alias lookups private servers uit VLAN 50.

12 tests, 0 failures
```

Alle tests zijn geslaagd

## Testinfo

Uitvoerder(s) test: Lander Van den Bulcke
Uitgevoerd op: 23/10/2017
