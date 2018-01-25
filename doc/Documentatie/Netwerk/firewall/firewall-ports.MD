#Ports firewall
##Alfa1: LDAP
Ports: 389/TCP | *636/TCP (SSL)*  
Eventueel: 3268/TCP | *3269/TCP (SSL)*
##Bravo1: Authorative-Only DNS
Ports: 53 UDP & TCP
##Charlie1: Slave DNS
Ports: 53 UDP & TCP
##Delta1: Mailserver (SMTP & IMAP)
SMTP Ports: 25/TCP | 465/TCP (Secure)  
IMAP Ports: 143/TCP | 993/TCP (Secure)
##Echo1: Webserver (HTTP/HTTPS/DRUPAL)
Ports: 80/TCP | 443/TCP
