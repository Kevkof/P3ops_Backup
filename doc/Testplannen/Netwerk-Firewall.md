# Testplan : Firewall PFSense

**Auteur(s) testplan**: Kjell Viaene

### Checklist

- [ ] Firewall Boot normaal
- [ ] De servers van VLAN 50 kunnen bereikt worden van buiten het netwerk en intern
- [ ] De servers van VLAN 30 kunnen niet bereikt worden van buiten het netwerk maar wel intern
- [ ] De clients van VLAN 20 kunnen niet bereikt worden van buiten het netwerk maar wel intern
- [ ] Alle hosts hebben internet access
- [ ] De juiste poorten staan open op de Firewall

### Testen bereikbaarheid
- Ping naar een server van VLAN 50 van buiten het intern netwerk (Bijvoorbeeld van uit het windows netwerk) (should SUCCEED)
- Ping naar een server van VLAN 30 van buiten het intern netwerk (Bijvoorbeeld van uit het windows netwerk) (should FAIL)
- Ping naar een client van VLAN 20 van buiten het intern netwerk (Bijvoorbeeld van uit het windows netwerk) (should FAIL)

- Ping naar een server van VLAN 50 van binnen het intern netwerk (verbind met een andere switch dan S1) (should SUCCEED)
- Ping naar een server van VLAN 30 van binnen het intern netwerk (verbind met een andere switch dan S2) (should SUCCEED)
- Ping naar een client van VLAN 20 van binnen het intern netwerk (verbind met een andere switch dan S3) (should SUCCEED)

### Internet access Testen
- Verbind met een switch (S1,S2 of S3) en surf naar een willekeurige site (should succeed)

### Controleren firewall instellingen
- Surf naar `172.16.129.13` vanaf een systeem in het intern netwerk (LAN)
  - Log in met `admin` `admin`
  - Navigeer naar `Firewall -> WAN` en controleer de rules
  - Navigeer naar `Firewall -> LAN` en controleer de rules
- Poorten die open dienen te zijn:

|Service   | Port  |
|---       |    ---|
| LDAP     |   389 |
| DNS      |    53 |
| SMTP     |    25 |
| SMTP (s) |   465 |
| IMAP     |   143 |
| IMAP (s) |   993 |
| HTTP     |    80 |
| HTTPS    |   443 |
