- Opzetten servers moet geautomatiseerd worden.
- Opzetten netwerk moet in de amte van het mogelijke geautomatiseerd worden.
- Voorbereiding moet beter, duidelijker rollen/afspraken/stappen afspreken.
- Het belangrijkste dat zou moeten verbeteren is het opzetten van de virtuele servers, dit zou automatisch moeten gebeuren.
- Ook het opzetten van het netwerk moet een stuk rapper. (Dit is denk ik ook wel ten gevolge van de ouderdom van het netwerkapparatuur)
- Hetgeen wat ik zeker ga onthouden dat is dat "Het werkt locaal" niet hetzelfde is als "het zal op de server ook wel werken.
- Playbook wie welke taak moet uitvoeren bij de finale release
- Elk uur een timer laten afgaan om een stand van zaken te geven. Soort van tussentijdse standup.
- Niet geheel duidelijk wat een subgroep kan bijbrengen tot de eind-release op het moment men denk te code klaar te hebben. De code wordt op de master gepusht maar verder is het onduidelijk wat een subgroep nog moet bijbrengen. Hoe kan een subgroep testen of de code volledig werkt. Zou iedere subgroep een soort integratietestplan moeten klaarhebben tegen de eindrelease om uit te testen of services effectief functioneren?
- Beter werkverdeling opstellen
- Met meerdere teams tegelijk bezig zijn.
- Het is zeer belangrijk alles zorgvoldig te testen op voorhand
- Bepaalde zaken kunnen beter op voorhand voorbereid worden (vm server + cross-over kabel)
- Betere afspraken
- Betere taakverdeling
- Betere automatisering
- Hoewel er al veel geautomatiseerd is moet er zeker nog meer gebeuren op dit vlak. Nu verliep alles op zich wel vlot maar veel te traag.
- Het uitvoeren van het complete playbook neemt behoorlijk wat tijd in beslag, dit moet zeker ingecalculeerd worden.
- Er moeten duidelijkere testplannen en handleidingen worden uitgeschreven, niet alleen voor de individuele componenten maar ook voor de hele opstelling.
- Er moet zeker in de weken voor de productie-release een soort repetitie gehouden worden, waar we het hele green-gedeelte van het netwerk proberen opstellen in 3 uur tijd.
- De voorbereiding was zeer leerrijk en we hebben eigenlijk een stappenplan kunnen opstellen die we kunnen toepassen op de final release. Eerst zetten we de gehele netwerkomgeving op en toewijzing van alle IP-adressen en vervolgens kunnen we de ansible book deployen.
- Betere voorbereiding, zowel voor de fysieke implementatie als troubleshooting
- Het opzetten van het netwerk en de machines moet sneller en efficiënter verlopen zodat er meer tijd over blijft om eventuele andere fouten op te lossen en de servers grondiger te kunnen testen.
- Testen is zeer belangrijk, zowel het testen van de werking van een server individueel als het geheel met alle servers samen.
- Naar volgende oplevering toe moeten we zeker meer ervaring opdoen met het klaarmaken van de servers om zo weinig mogelijk tijd te verliezen. 
    - Rekening houden met de routers voor de scripts met de instellingen
    - meer informatie nodig op de topologien
    - we hadden beter een kleine fysieke test opstelling gemaakt voor W6
- Het is niet altijd vanuit een simulatieomgeving in te schatten of het bij productie zal werken.
- Er kwamen fouten met de ip's door het op laatste omgooien van de adressering voor de fysieke machines en de KVM
- Het is niet altijd gemakkelijk om in een grote groep te werken.
-->
