# Testplan: lima1  SAMBA servers

**Opstellers van testplan: David Gooskens, Ruben Bruggeman**

- [] De SMB service draait.
- [] De users zijn aangemaakt.
- [] De groups zijn aangemaakt.
- [] De SAMBA shares zijn aangemaakt.
- [] Elke SAMBA users heeft een home directory.
- [] Elke SAMBA user heeft in zijn aangewezen share lees-en schrijfrechten.


## Test 1 - opstarten VM:

1. Ga vanop de host-machine naar de map met de vagrantfile van het project via de command-line.
2. Als je je in de map bevindt, typ het volgende commando om te controleren of de vm's al dan niet zijn aangemaakt.
3. Maak gebruik van het commando: `vagrant status`.

* Hier krijg je een lijst van machines met hun status, de vm papa1 zou "not created" moeten zijn, als dit niet zo is voer je het commando `vagrant destroy -f lima1` uit
* Voor het aanmaken van de vm papa1 typ je het volgende commando: `vagrant up lima1`

* Verwachte resultaten:
    - Via de GUI van VirtualBox zien we de vm lima1 draaien
    - De laatste uitvoerlijn op de commandline heeft volgende uitvoer

Zonder kickstart files
```
PLAY RECAP *********************************************************************
lima1                      : ok=49   changed=29   unreachable=0    failed=0
```

## Test 2 - Status van de SMB service:

1. In de commandline volgend commando uitvoeren:  `sudo systemctl status smb`
2. Het verwachte resultaat is onderstaande output:

```
● smb.service - Samba SMB Daemon
   Loaded: loaded (/usr/lib/systemd/system/smb.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2017-12-11 15:12:51 UTC; 15min ago
 Main PID: 5803 (smbd)
   Status: "smbd: ready to serve connections..."
   CGroup: /system.slice/smb.service
           ├─5803 /usr/sbin/smbd
           ├─5804 /usr/sbin/smbd
           └─5805 /usr/sbin/smbd

Dec 11 15:12:50 lima1 systemd[1]: Starting Samba SMB Daemon...
Dec 11 15:12:51 lima1 smbd[5803]: [2017/12/11 15:12:51.014885,  0] ../lib/util/become_daemon.c:124(daemon_ready)
Dec 11 15:12:51 lima1 systemd[1]: Started Samba SMB Daemon.
Dec 11 15:12:51 lima1 smbd[5803]:   STATUS=daemon 'smbd' finished starting up and ready to serve connections
```

## Test 3 - Creatie van de users:

1. In de commandline volgend commando uitvoeren: `cat /etc/passwd`
2. De 5 laatste lijnen zouden onderstaande output moeten zijn:

```
lander:x:1001:1006:Lander Van den Bulcke:/home/lander:/bin/bash
torvalds:x:1002:1007:Linus Torvalds:/home/torvalds:/bin/bash
rms:x:1003:1008:Richard Stallman:/home/rms:/bin/bash
knuth:x:1004:1009:Donald Knuth:/home/knuth:/bin/bash
dmr:x:1005:1010:Dennis Ritchie:/home/dmr:/bin/bash
```

## Test 4 - Creatie van de groups:

1. In de commandline volgend commando uitvoeren: `cat /etc/group`
2. In de output zou onderstaande aanwezig moeten zijn:

```
itadministratie:x:1001:lander
verkoop:x:1002:torvalds
administratie:x:1003:rms
ontwikkeling:x:1004:knuth
directie:x:1005:dmr
```

## Test 5 - Creatie van de samba_shares:

1. In de commandline volgend commando uitvoeren: `ls /srv/shares`
2. Onderstaande output wordt verwacht:

```
[root@lima1 ~]# ls /srv/shares/
administratie  directie  itadministratie  ontwikkeling  verkoop
```

## Test 6 - Toegang tot de shares:

1. We gaan testen voor user `dmr` met wachtwoord `password` in group `directie`.
2. Voer in de commandline volgend commando uit: `sudo smbclient  //172.16.128.5/directie -Udmr%password`
3. De onderstaande output wordt verwacht:
```
WARNING: The "syslog only" option is deprecated
WARNING: The "syslog" option is deprecated
Domain=[LIMA1] OS=[] Server=[]
smb: \> ls
  .                                   D        0  Mon Dec 11 16:00:51 2017
  ..                                  D        0  Mon Dec 11 16:00:51 2017

                38770180 blocks of size 1024. 37301828 blocks available
```

4. Voor user `dnr` maken we de directory `iets` aan.
```                
smb: \> mkdir iets
smb: \> exit
```

5. Controle op de aanwezigheid van de directory `iets` wordt op onderstaande manier gecontroleerd:
```
[vagrant@lima1 ~]$ cat /srv/shares/directie/iets/
cat: /srv/shares/directie/iets/: Is a directory
```

## Test 7 - Schrijf- en leesrechten voor de aanwezige users in de aangewezen groups:

1. We gaan nu controleren dat een user uit een group WEL kan lezen in een directory die behoort aan een user van een andere group, maar NIET kan schrijven in die group.
2. Voer in de commandline onderstaand commando uit:
```
[vagrant@lima1 ~]$ sudo smbclient  //172.16.128.5/verkoop -Udmr%password
```

3. Onderstaande output is het verwachte resultaat.
```
WARNING: The "syslog only" option is deprecated
WARNING: The "syslog" option is deprecated
Domain=[LIMA1] OS=[] Server=[]
```

4. Probeer nu een directory `iets` aan te maken. Zoals in de onderstaande output, moet dit geweigerd worden:
```
smb: \> mkdir ieetske
NT_STATUS_ACCESS_DENIED making remote directory \ieetske
smb: \> exit
```
