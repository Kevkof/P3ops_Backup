# Stappenplan werken met GitHub

**Belangrijk: NIEMAND commit op de master branch, volg onderstaand stappenplan!"**

Gezien we werken met branches is het belangrijk dat iedereen hetzelfde stramien volgt. De basismethode gaat als volgt:

Het is altijd een goed idee om te beginnen met de laatste versie van de master:
  ```bash
  git pull
  ```

Maak daarna een nieuwe branch aan voor de feature waar je aan werkt. Probeer een duidelijk naamgeving te hanteren: `taak/feature` is een goed begin. (voorbeeld: `ldap/toevoegen-gebruikers`)
  ```bash
  git checkout -b taak/feature
  ```

Nu kan je gewoon normaal comitten op deze branch:
  ```bash
  git add .
  git commit -m "Commit message"
  ```

Probeer ook altijd een duidelijke commit message te gebruiken. Dingen als "toevoegingen" of "stuff" zijn nutteloos. Probeer te omschrijven wat de wijzigingen in de commit juist doen.

Andere mensen uit je team kunnen ook meewerken op deze branch. Om een bestaande branch van GitHub op te halen gebruik je volgende commando's:
  ```bash
  git checkout -b taak/feature
  git pull origin taak/feature
  ```

Vergeet niet om je commits regelmatig naar GitHub te pushen:
  ```bash
  git push origin taak/feature
  ```

Eens je feature klaar is kan je een pull request aanmaken om de code in de `master` branch te krijgen. **Opgelet: maak enkel voor werkende code een pull request!** Zolang je code niet werkt, werk je verder op je eigen branch, zodat de andere teams er geen invloed van ondervinden.

Wanneer je onlangs gecommit hebt zal GitHub je vragen of je een pull request wil maken. Dit dien je dus pas te doen als je feature klaar is. **Opgelet: het mergen zelf laat je aan Ruben over. Je dient dus enkel een pull request in!**


Bij een aantal groepjes is het al voorgevallen dat een aantal personen per ongeluk zelf een branch aanmaken i.p.v. te verbinden met de al reeds bestaande branch waar ze eigenlijk mee wilden connecteren. In feite geen probleem, want een lokale aangemaakte branch aan een remote branch koppelen kan als volgt :
  ```bash
  git branch --set-upstream-to-origin/<remote branch> <lokale branch>
  ```

Het kan gebeuren dat je (een soortgelijke) onderstaande foutmelding krijgt bij het pullen op de master of een andere willekeurige branch:

![knipsel](https://user-images.githubusercontent.com/17174588/33234089-ff31d752-d220-11e7-952b-2421e37d519c.PNG)

Ik heb gezien dat deze foutmelding zich bij meerdere mensen deze week heeft voorgedaan. Dit is te wijten aan het feit dat GitHub blijkbaar conflicten ziet met eerder gemergde & afgesloten branches. Je kan onderstaande commando's uitvoeren om het probleem op te lossen:

```
git remote prune origin
git pull origin <branch>
```

**Nog een aantal (samenvattende) belangrijke puntjes:**

- Wees steeds duidelijk en specifiek genoeg in de naam bij het aanmaken van een branch!
- Een branch wordt aangemaakt per feature dat je wenst te pushen naar de master (implementatie en incrementeel werken) , niet gewoon een branch maken per persoon of per subgroep ! Dit maakt het ingewikkeld om alles correct te mergen.
- GEEN commits naar de master doen ! Doe altijd een pull request via de tab in de p3ops-green repository !
- Alvorens je een branch wenst aan te maken en/of te pushen door een pull request te doen, eerst steeds een pull van de upstream doen !
- Elke branch wordt verwijderd nadat de request werd goedgekeurd en de betreffende branch werd gemerged.

