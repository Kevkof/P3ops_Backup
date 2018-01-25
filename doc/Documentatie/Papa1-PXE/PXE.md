# Documentatie PXEboot

## Gebruikte rollen

- [bertvv.rh-base](https://github.com/bertvv/ansible-role-rh-base)
- [bertvv.pxeserver](https://github.com/bertvv/ansible-role-pxeserver)
- [bertvv.tftp](https://github.com/bertvv/ansible-role-tftp)

## Uitleg variabelen

### tftp

|Naam variabele|Waarde|Beschrijving|
|:---|:---|:---|
|root_directory|`/srv/tftp`|We hebben de locatie ingesteld op `/srv/tftp`|
|server_args|`--secure --create`|Create: Toelaten dat nieuwe files aangemaakt worden. secure: past de root directory aan bij start up, er moet maar 1 folder meegegeven worden in commands|
|mode|`0755`|De mode ingesteld op root_directory (chmod stijl)|
|setype|`public_content_rw_t`|De SELinux context voor de root_directory, `public_content_rw_t` laat toegang via andere services toe|
|anon_write|`yes`|Dit laat toe dat tftp publieke bestanden aanpast|

### Odd ones

| Naam variabele    | Waarde                | Beschrijving                                 |
|:------------------|:----------------------|:---------------------------------------------|
| imagecentos7_url  | `<imagecentos7_url>`  | De link naar de squashfs image voor Centos 7 |
| imagefedora27_url | `<imagefedora27_url>` | De link naar de install image voor Fedora 27 |

### pxe_server

| Naam variabele | Waarde           | Beschrijving                                                    |
|:---------------|:-----------------|:----------------------------------------------------------------|
| ip             | `172.16.128.9`   | Het ip adres van de PXE server                                  |
| images         | Argumenten lijst | Dit bevat de lijst van images die beschikbaar zijn op de server |

Voorbeeld entry

| Naam variabele | Waarde            | Beschrijving                                       |
|:---------------|:------------------|:---------------------------------------------------|
| name           | `Fedora26`        | De naam van het os (dit wordt ook de mapnaam)      |
| default        | `true`            | Bepaalt of dit het standaard te deployen os is     |
| kernel_url     | `<kernel_url>`    | Vanaf deze url wordt de kernel gedownload          |
| initrd_url     | `<initrd_url>`    | Vanaf deze url wordt de initrd image gedownload    |
| kickstart_path | `<kickstart_path` | Vanaf dit pad wordt de kickstart config gekopiëert |
| label          | `Fedora 26`       | Het label dat getoond zal worden bij het boot-menu |
