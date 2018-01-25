# client install Fedora gebruikmakend van kickstart bestand.

## Kickstarter aanroepen door gebruik te maken van github

### prerequisits
- de virtual box moet werken.
- Fedora netstart iso moet zijn aangesloten.

### manuele bootup
Het script zal bij start automatisch installeren. Alleen moet de bootloader het script kunnen raadplegen.

hiervoor wordt bij het starten van de livecd op esc geduwd.

Typ dan het volgende comando
```
linux ks=https://github.com/HoGentTIN/p3ops-green/blob/Clients/scripts/pxe/anaconda-ks.cfg
```

de installatie loopt vanaf nu automatisch
