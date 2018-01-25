# Documentatie Monitoring server Oscar1

## Algemene info

Oscar1 is de monitoring server. Deze server verzamelt gegevens van alle andere servers, en geeft deze weer in een dashboard. Hiervoor wordt gebruik gemaakt van 3 tools:

- Elasticsearch: Dit is een soort databank op de monitoring server waarin alle info van de servers bewaard wordt.

- Metricbeat: Een stukje software die op elke server geïnstalleerd wordt, en informatie van deze server doorstuurt naar elasticsearch op de monitoring server.

- Kibana: Geeft een dashboard weer waarop de gegevens uit Elasticsearch kunnen weergegeven worden.

## Gebruikte rollen

- [geerlingguy.kibana](https://github.com/geerlingguy/ansible-role-kibana)
- [geerlingguy.java](https://github.com/geerlingguy/ansible-role-java)
- [geerlingguy.elasticsearch](https://github.com/geerlingguy/ansible-role-elasticsearch)
- metricbeat (eigen rol)



## Uitleg gebruikte variabelen

In het variabelenbestand `ansible/host_vars/oscar1.yml` zijn enkele variabelen van deze rollen gedeclareerd. Ze doen het volgende:

```yaml
kibana_server_port: 80
```
Deze variabele zorgt ervoor dat kibana op poort 80 van de server draait en dus automatisch opent bij het surfen naar het ip adres van oscar.

```yaml
kibana_elasticsearch_url: "http://localhost:9200"
```

Deze variabele laat kibana over poort 9200 verbinding maken met elasticsearch.

```yaml
elasticsearch_network_host: "localhost"
elasticsearch_http_port: 9200
```

Het netwerkadres en de netwerkpoort waarop geluisterd wordt voor inkomende connecties.

```yaml
elasticsearch_script_inline: true
elasticsearch_script_indexed: true
```

Inline scripting wordt toegelaten.

```yaml
beats_config_file: files/servers.yml
```

Het configuratiebestand voor de beats op elke server. Hierin staat naar welk ip adres en poort de gegevens verstuurd worden, en welke gegevens er precies verstuurd worden.



## Configuratiebestand

Het configuratiebestand ziet er als volgt uit.

```yaml
metricbeat.modules:
- module: system
  metricsets:
    # CPU stats
    - cpu

    # System Load stats
    #- load

    # Per CPU core stats
    #- core

    # IO stats
    #- diskio

    # Per filesystem stats
    #- filesystem

    # File system summary stats
    #- fsstat

    # Memory stats
    - memory

    # Network stats
    - network

    # Per process stats
    #- process

    # Sockets (linux only)
    #- socket
  enabled: true
  period: 10s
  processes: ['.*']

output.elasticsearch:
  hosts: ["172.16.128.8:9200"]

```
Afhankelijk van het soort toestel wordt een configuratiebestand met andere gegevens geselecteerd.

## Post-tasks

Na het uitvoeren van de rollen worden bij deze server nog 2 post-tasks uitgevoerd. Zij voeren het volgende uit:


```yaml
post_tasks:
    - name: open port 80 kibana
      shell: setcap cap_net_bind_service=+ep /opt/kibana/node/bin/node
```
Poort 80 wordt geopend zodat kibana hierop kan gedraaid worden.

```yaml
post_tasks:
    - name: import predefined dashboards
      shell: /usr/share/metricbeat/scripts/import_dashboards -es http://172.16.128.6:9200
```
Het voorgedefinieerde Kibana dashboard wordt geimporteerd. 