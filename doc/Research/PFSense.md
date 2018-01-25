# Research PFSense firewall

## Installation

- [Introduction to PFSense](https://www.pfsense.org/getting-started/)
- [Youtube: Installation of PFSense 2.3] (https://www.youtube.com/watch?v=7nr9HNZ7OmY)
- [Youtube pfSense firewall setup of PFSense 2.4](https://www.youtube.com/watch?v=OfZPOO2nu5g)

### Remarks
- Make sure there are 2 network cards active before you start installing
- Select the correct keymapping while installing, the rest of the option can stay as suggested
- First thing to do after installation is to check if PFSense chose the correct interfaces for WAN and LAN
  - Chose to `Assign Interfaces`, option 1
  - Use the MAC adresses of your networkcards to determine which one is em0 and which one is em1.
  - When this is done, both interfaces should have an IP
  
- Ik veronderstel dat ook deze server geautomatiseerd moet worden en hiervoor hebben we dus een rol nodig

### Automatisation

- 1) zelf script schrijven via PHP Shell
  - [mogelijke pfsense automatisatie met behulp van PHP pfsense Shell] (https://doc.pfsense.org/index.php/Using_the_PHP_pfSense_Shell)
- 2) de mogelijkheid, via webGui configureren en dan exporten naar en als automatisatie "backup settings runnen 

### Extra eventuele randinformatie

- [role voor pfSense] (https://github.com/amatas/ansible-pfsense)
- [ansible role firewall] (https://github.com/geerlingguy/ansible-role-firewall)
- [ansible comands voor firewall (firewalld)] (http://docs.ansible.com/ansible/latest/firewalld_module.html)
  - vb template
    - firewalld:
      - zone
      - service/port/source: (https)/(8081/tcp)/(192.0.2.0/24)
      - permanent: (true)
      - state: (enabled)