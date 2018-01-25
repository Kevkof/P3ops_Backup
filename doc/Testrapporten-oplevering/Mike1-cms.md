# Testrapport: Mike1 CMS

- [ ] Opstarten slaagt zonder errors.
- [ ] Testscript van delta1 geeft geen fouten.

Uitvoerder(s) test: Florian Van Steen
Laatst uitgevoerd op: 18/12/2017

## Test 1 - Uitvoeren testscript mike1

- Het testscript kan runnen
- Alle testen in het testcript slagen

```
...
Running test /vagrant/tests/mike1/mike1.bats
 ✓ The necessary packages should be installed
 ✓ The Apache service should be running
 ✓ The Apache service should be started at boot
 ✓ The SELinux status should be ‘enforcing’
 ✓ Web traffic should pass through the firewall
 ✓ Check if the firewall is allowing port 389/tcp
 ✓ The website should be accessible through HTTP at the right ip address
 ✓ The Wordpress install page should be visible under http://172.16.128.6/wordpress/

8 tests, 0 failures
```
-Alle test zijn geslaagd

## Test 2 - Controleer of de wordpress bereikbaar is 

- Kan pagina bekijken via https://172.16.128.6/wp-admin/install.php
