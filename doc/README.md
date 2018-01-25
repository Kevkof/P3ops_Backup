
## Overzicht van de documentatie

### Serveroverzicht
| Server       | Type                                | Handleiding                                                                      | Testplan                                       | Testrapport                                            |
| ------------ | ----------------------------------- | -------------------------------------------------------------------------------- | ---------------------------------------------- | ------------------------------------------------------ |
| Alfa1        | LDAP                                | [Handleiding](Documentatie/Alfa1-LDAP/ldap.md) <br/> [389-ds-config](Documentatie/Alfa1-LDAP/role-389-ds-config.md)    | [Testplan](Testplannen/Alfa1-ldap.md)       | [Testrapport](Testrapporten/Alfa1-ldap.md)       |
| Bravo1       | DNS-master                          | [Handleiding](Documentatie/Bravo1_Charlie1-DNS/DNS.md)     | [Testplan](Testplannen/Bravo1_Charlie1-DNS.md) | [Testrapport](Testrapporten/Bravo1_Charlie1-DNS.md)|
| Charlie1     | DNS-slave                           | [Handleiding](Documentatie/Bravo1_Charlie1-DNS/DNS.md)     | [Testplan](Testplannen/Bravo1_Charlie1-DNS.md) | [Testrapport](Testrapporten/Bravo1_Charlie1-DNS.md)|
| Delta1       | Mail                                | [Handleiding](Documentatie/Delta1-Mailserver/Mailserver.md)           | [Testplan](Testplannen/Delta1-mailserver.md)   | [Testrapport](Testrapporten/Delta1-Mailserver.md)|
| Echo1        | Web                                 | [Handleiding](Documentatie/Echo1-Webserver/Web.md)         | [Testplan](Testplannen/Echo1-Webserver.md)     | [Testrapport](Testrapporten/Echo1-Webserver.md)  |
| Kilo1        | DHCP                                | [Handleiding](Documentatie/Kilo1-DHCP/DHCP.md)             | [Testplan](Testplannen/Kilo1-DHCP.md)          | [Testrapport](Testrapporten/Kilo1-dhcp.md)    |
| Lima1        | file                                | [Handleiding](Documentatie/Lima1-Samba/samba.md)           | [Testplan](Testplannen/Lima1-SMB.md)          |[Testrapport](Testrapporten/Lima1-smb-standalone.md) |
| Mike1        | CMS                                 | [Handleiding](Documentatie/Mike1-CMS/CMS.md)               | [Testplan](Testplannen/Mike1-cms.md)        | [Testrapport](Testrapporten/Mike1-cms.md)        |
| November1    | Database                            | [Handleiding](Documentatie/November1-Database/Database.md) | [Testplan](Testplannen/November1-MariaDB.md)    | [Testrapport](Testrapporten/November1-MariaDB.md)    |
| Oscar1       | Monitoring                          | [Handleiding](Documentatie/Oscar1-monitoring/oscar1.md) <br/> [Metricbeat](Documentatie/Oscar1-monitoring/metricbeat.md) | [Testplan](Testplannen/Oscar1-monitoring.md) | [Testrapport](Testrapporten/Oscar1-monitoring.md) |
| Papa1        | PXE                                 | [Handleiding](Documentatie/Papa1-PXE/PXE.md)                | [Testplan](Testplannen/Papa1-PXE.md)        | [Testrapport](Testrapporten/Papa1-pxe.md) |
| Quebec1      | DNS forwarder                       | [Handleiding](Documentatie/Quebec1-ForwardingDNS/DNSmasq.md)| [Testplan](Testplannen/Quebec1-DNSForwarder.md)    | [Testrapport](Testrapporten/Quebec1-DNSForwarder.md)    |
| Workstations | Clients                             | [Handleiding](Documentatie/Installatie-Clients/clientit1.md)| [Testplan](Testplannen/clients-standalone.md)                                      |                                                      |

### Netwerkmodellen
| Onderwerp     | PDF-formaat                              | VSDX-formaat                               | Testplan                                          | Testrapport                                               |
| ------------- | ---------------------------------------- | ------------------------------------------ | ------------------------------------------------- | --------------------------------------------------------- |
| Logisch model | [PDF](Documentatie/Netwerk/topologie/LogischeTopologie.pdf) | [VSDX](Documentatie/Netwerk/topologie/LogischeTopologie.vsdx) | [Testplan](Testplannen/Netwerk-logisch-model.md) | [Testrapport](Testrapporten/Netwerk-logisch-model.md) |
| Fysiek model  | [PDF](Documentatie/Netwerk/topologie/FysiekeTopologie.pdf)  | [VSDX](Documentatie/Netwerk/topologie/FysiekeTopologie.vsdx)  | [Testplan](Testplannen/Netwerk-Fysiek-model.md)  | [Testrapport](Testrapporten/Netwerk-fysiek-model.md)  |
| Topologie     | [PDF](Documentatie/Netwerk/topologie/Topologie.pdf)         |                                            |                                                   |                                                           |


### Netwerkoverzicht
| Onderwerp     | Handleiding                                          | Testplan                                         | Testrapport                                              |
| ------------- | ---------------------------------------------------- | ------------------------------------------------ | -------------------------------------------------------- |
| IP Subnetting |                                                 | [Testplan](Testplannen/Netwerk-IPSubnetting.md) | [Testrapport](Testrapporten/Netwerk-ipsubnetting.md) |
| Firewall      | [Handleiding](Documentatie/Netwerk/firewall/firewall-pfsense.md)  |                                            |                                                     |
| Packettracer  |                                                  | [Testplan](Testplannen/Netwerk-packettracer.md) | [Testrapport](Testrapporten/Netwerk-packettracer.md) |
| Router        | [Handleiding](Documentatie/Netwerk/router/configureren-router.md)  |                                                  |                                                          |
| Switch        | [Handleiding](Documentatie/Netwerk/switch/configureren-switch.md) |                                                  |                                                          |

### Troubleshooting

- [Connectie LDAP/Wordpress](Troubleshooting/ldap-wordpress.md)
