# Testrapport Delta1

Checklist
- [x] Opstarten slaagt zonder errors.
- [x] Testscript van mailserver geeft geen fouten.
- [x] Zonder problemen mail sturen vanuit mailclient vanop workstation
- [x] Zonder problemen mail sturen vanuit squirrelmail

Auteur(s) testrapport: Robbe Devos

Uitgevoerd op: 18/12/2017

## Test 1 - Uitvoeren testscript delta1
- Script kan uitgevoerd worden zonder problemen
- Alles testen in het script zijn geslaagd

```
Running test /vagrant/tests/delta1/mailserver.bats
 ✓ The necessary packages should be installed
 ✓ The Postfix service should be running
 ✓ The Dovecot service should be running
 ✓ The SELinux status should be ‘enforcing’
 ✓ Web and mail traffic should pass through the firewall
 ✓ The users robbe and robin should exists
 ✓ The website should be accessible through HTTP at the right ip address
 ✓ The squirrelmail page should be visible under http://172.16.128.135/squirrelmail/

8 tests, 0 failures
```

## Test 2 - Mail sturen vanuit mailclient

- Ik kan de account robbe en robin toevoegen aan de mailclient
- De mail vanuit robbe komt aan bij robin
- de mail vanuit robin komt aan bij robbe


## Test 3 - Mail sturen vanuit squirrelmail

- Ik kan aanmelden als robbe
- ik kan mij aanmelen als robin
- De mail die ik vanuit robbe heb gestuurd komt aan bij robin

## Test4 - Mail sturen van Linux naar Windows
- De mail die linux naar windows stuurt komt aan.
- de mail die windows naar linux stuurt komt aan.
