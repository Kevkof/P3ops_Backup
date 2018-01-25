# Testrapport : November 1

- [x] Opstarten slaagt en start op zonder errors.
- [x] Testscript van de database geeft geen fouten
- [x] Echo1 en Mike1 kunnen verbinden met de database

Uitvoerder(s) testplan: Pieter-Jan

Uitgevoerd op 18/12

## Test 2: Uitvoeren testscript november1

- Test script kan uitgevoerd worden
- Alle testen in het testscript werken

```
Running test /vagrant/tests/november1/november1.bats
 ✓ The MariaDB service should be running
 ✓ The MariaDB service should be started at boot
 ✓ The SELinux status should be ‘enforcing’
 ✓ Mysql traffic should pass through the firewall
 ✓ Mariadb should have a root user "november1" and password "november1"
 ✓ Mariadb should have a DB "echo1DB"
 ✓ Mariadb should have a DB "mike1DB"
 ✓ The MariaDB root user (november1) user should have "write access" to the database

 8 tests, 0 failures
```
