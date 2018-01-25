# Documentatie DNSmasq (Quebec1)

## Gebruikte rollen

- [bertvv.rh-base](https://github.com/bertvv/ansible-role-rh-base)
- [bertvv.dnsmasq](https://github.com/bertvv/ansible-dnsmasq)

## Uitleg variabelen
```yaml
rhbase_firewall_allow_services:
  - dns
```
Deze variabele zorgt ervoor dat de DNS services worden doorgelaten door de firewall.

```yaml
dnsmasq_domain: 'green.local'
dnsmasq_domain_needed: false
```
De0 ``dnsmasq_domain`` variabele geeft het domein ``green.local`` mee aan de DNSMasq server.
de ``dnsmasq_domain_needed: false`` geeft aan dat ook  verzoeken zonder domain name worden beantwoord. Deze regel is hoogstwaarschijnlijk overbodig, deze was toegevoegd om een probleem met interne DNS requests op te lossen maar heeft dit niet gedaan.

```yaml
dnsmasq_upstream_servers:
# - green.local DNS Servers
  - /green.local/172.16.128.133 #ns1.green.local #bravo1
  - /green.local/172.16.128.134 #ns2.green.local #charlie1
# - red.local DNS Servers
  - /red.local/172.18.2.67 #ns1.red.local #alfa2
  - /red.local/172.18.2.68 #ns2.red.local #bravo2
# - HogentDNS ns1.hogent.be / ns2.hogent.be
  - 193.190.173.1
  - 193.190.173.2

```
De ``dnsmasq_upstream_servers`` set de IP adressen van de [upstream servers](https://en.wikipedia.org/wiki/Upstream_server) direct. Dit gebeurt voor 3 verschillende zones.
1. De lokale zone ``green.local`` aangegeven met de ``/green.local/``. Deze geeft beide IP-adressen van ``ns1/ns2.green.local``.
2. De zone ``red.local``. Deze geeft aan dat al het verkeer voor ``/red.local/`` wordt doorgestuurd naar de ip adressen van de DNS servers van ``red.local``. De toegevoegde /red.local/ voor de ip adressen is gebasseerd op [dit artikel](http://www.thekelleys.org.uk/dnsmasq/docs/setup.html), te lezen onder "Using Special Servers".
3. De overige DNS request zullen worden doorgegeven naar de DNS servers van HoGent. ``ns1/ns2.hogent.be``
