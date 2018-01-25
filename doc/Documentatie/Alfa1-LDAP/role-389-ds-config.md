# Documentatie role 389-ds-config

Deze rol maakt de nodige OU's, groepen en gebruikers aan op de LDAP server.

## Dependencies

De enige dependency is `CSCfi.389-ds`. Deze role installeert de LDAP server, en de role `389-ds-config` maakt gebruik van enkele van de configuratievariabelen van die rol.

## Variabelen

- `dirsrv_remove_entries`: Entries die verwijderd moeten worden (zoals de entries die standaard aangemaakt worden)
   - **Default:** `[]`
   - **Syntax:** `- "ou=Groups,dc=green,dc=local"`

- `dirsrv_groups`: Groepen die moeten toegevoegd worden, met hun leden
  - **Default:** `[]`
  - **Syntax:**
    ```yaml
    - name: groepnaam
      gidnumber: 111
      members:
        - uid1
        - uid2
    ```
    | Veld        | Omschrijving                                                                |
    | :---        | :---                                                                        |
    | `name`      | De naam van de groep.                                                       |
    | `gidnumber` | Het group-id (getal) dat door Linux zal gebruikt worden.                    |
    | `members`   | Een lijst van `uid`s van bestaande gebruikers die in de groep moeten komen. |

- `dirsrv_users`: Gebruikers die moeten aangemaakt worden
  - **Default:** `[]`
  - **Syntax:**
    ```yaml
    - uid: user1
      cn: Voornaam Familienaam
      sn: Familienaam
      description: Beschrijving
      password: "{SSHA}hashedpassword"
      uidnumber: 111
      gidnumber: 111
      loginshell: /bin/bash
      homedirectory: /home/user1
    ```
    | Veld            | Omschrijving                                                                                                          |
    | :---            | :---                                                                                                                  |
    | `uid`           | De user-id (login) voor de gebruiker.                                                                                 |
    | `cn`            | De 'common name'; de naam die door LDAP gebruikt wordt.                                                               |
    | `sn`            | De 'surname'; de familienaam van de gebruiker dus.                                                                    |
    | `description`   | Een beschrijving van de gebruiker                                                                                     |
    | `password`      | Het paswoord van de gebruiker, in een hash. ([generator](http://projects.marsching.org/weave4j/util/genpassword.php)) |
    | `uidnumber`     | Het user-id (getal) dat door Linux zal gebruikt worden.                                                               |
    | `gidnumber`     | Het group-id (getal) dat door Linux zal gebruikt worden.                                                              |
    | `loginshell`    | De standaard shell voor de gebruiker.                                                                                 |
    | `homedirectory` | De locatie van de home-folder van de gebruiker.                                                                       |


- `dirsrv_auth`: De connectiegegevens voor de LDAP server. Deze kunnen ongewijzigd blijven. Voor meer informatie over de connectiegegevens, zie [de algemene LDAP documentatie](ldap.md).
  - **Default:**
    ```yaml
    dirsrv_auth:
      server_uri: "ldap://{{ dirsrv_fqdn }}/"
      bind_dn: "{{ dirsrv_rootdn }}"
      bind_pw: "{{ dirsrv_password }}"
    ```
  - **Syntax:**
    ```yaml
    dirsrv_auth:
      server_uri: "ldap://url.van.server/"
      bind_dn: "cn=Admin"
      bind_pw: "password"
    ```

