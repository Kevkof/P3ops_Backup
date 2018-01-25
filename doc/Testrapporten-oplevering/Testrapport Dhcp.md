# Testrapport : Kilo1 DHCP-server

**Opsteller(s) testrapport:** Kjell Viaene, Kasper Van Damme

Dit testplan zal de werking van de DHCP-server testen, zijnde `kilo1`.

Checklist

- [x] Opstarten slaagt en start op zonder errors.
- [x] DHCP-installatie is voltooid
- [x] DHCP-service draait
- [x] DHCP-instellingen komen overeen met de verwachtingen in IP-adressering.
- [x] Client krijgt een IP-adres via de DHCP-server


## Test 5 - DHCP-client

1. Connecteer via `Switch3 L2` met het lokaal netwerk in `VLAN20`
2. Zorgt dat uw IP dynamisch verkregen wordt
3. Schakel alle andere netwerkkaarten uit exclusief de ethernet adapter
4. Open een cmd sessie
  - [x] Client heeft een IP adres gekregen binnenin de correcte range
    - Voer `ipconfig /all` uit en controleer IP en subnet mask
    - Dit moet binnen de range `172.16.0.2 - 172.16.127.254`
  - [x] Client heeft de correcte default_gateway
    - Voer `ipconfig /all` uit en check of de default_gateway gelijk is aan `172.16.0.1`
  - [x] Client heeft de correcte DNS server
   - Voer `ipconfig /all` uit en check dat de DNS server's ip gelijk is aan  `172.16.128.10`
 5. Surf naar een willekeurige website
  - [x] Website wordt succesvol geladen
