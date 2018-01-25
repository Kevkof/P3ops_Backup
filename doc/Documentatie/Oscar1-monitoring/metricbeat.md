# Documentatie role metricbeat

* Info technische termen: zie technische documentatie Oscar1

## Algemene info

Deze rol maakt op een server een 'beat' aan die gegevens over de server verzamelt en naar elasticsearch op de monitoringserver verzendt.

## Dependencies

Deze rol heeft geen dependencies

## Variabelen

- `beats_package_name`: De naam van de te gebruiken package. 
  - **Default:** `metricbeat`

- `beats_package_version`: De versie van de te gebruiken beat.
  - **Default:** `5.2.2`


- `beats_install`: Of de beat al dan niet geinstalleerd dient te worden.
  - **Default:** `true`


- `beats_config_file`: Het pad van het te gebruiken configuratiebestand.
  - **Required**


