# Testrapport : DNS forwarder

Dit testplan zal de werking van de DNS forwarder testen, zijnde `quebec1`.

Checklist

- [x] DNS servers worden correct weergegeven voor zowel `green.local` als `red.local`.

1. Test of de juiste DNS-servers worden doorgegeven voor 'green.local' met het commando ´dig NS green.local @localhost +short´
	- 'bravo1.green.local' & 'charlie1.green.local' moeten opkomen.
2. Voer hetzelfde commando nu uit maar dan voor red.local. `dig NS red.local @localhost +short`
	- 'ns1.red.local' & 'ns2.red.local' moeten opkomen.
3. Als 172.16.128.10 (de DNSMasq) als DNS is ingesteld, is het mogelijk om de sites van green.local, red.local en buitenstaande sites (zoals google.com, YouTube.com, enz.) te bezoeken.
