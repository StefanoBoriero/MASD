// Agent chassisAssembler in project carFactory

/* Initial beliefs and rules */

boltProvider(boltProviderA).
boltProvider(boltProviderB).

/* Initial goals */

/* Plans */

/////////////////////////////

+chassisNeeded(X,Y) 
	<- 	!getBolts(500);
		!constructChassis(X,Y).

+!getBolts(Amount): true
	<- 	!askAllProviders;
		!chooseBestDeal.

+!askAllProviders : true
	<- 	for(boltProvider(P))
		{
			.send(P, achieve, priceEstimate(666));
		};
		.wait(500).

+!chooseBestDeal : deal(Amount, BestPrice)[source(Provider)] & not (deal(Amount, Price) & Price < BestPrice)
	<- 	.send(Provider, achieve, deliverBolts(Amount));
		for(deal(Amount,Price))
		{
			-deal(Amount,Price)[source(boltProviderA)];
			-deal(Amount,Price)[source(boltProviderB)];
		}.

+deliveredBolts(Amount)[source(Provider)]: true
	<- .print("Oh my god I got ", Amount, " awesome bolts from ", Provider).

+!constructChassis(X,Y) : true
	<-	.wait(500);
		.print("I constructed chassis ", X, ",", Y);
		!paintChassis(X,Y).		
		
+!paintChassis(X,Y) : true 
	<-	.send(painter,tell,paintChassisNeeded(X,Y)).

//////////////////////////////

+chassisPainted(X,Y)
	<- .send(qualityCheck,tell,chassisReady(X,Y));
		-chassisNeeded(X,Y).