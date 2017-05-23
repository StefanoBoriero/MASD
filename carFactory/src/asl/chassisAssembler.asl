// Agent chassisAssembler in project carFactory

/* Initial beliefs and rules */

boltProvider(boltProviderA).
boltProvider(boltProviderB).

/* Initial goals */

/* Plans */

/////////////////////////////

+chassisNeeded(X,Y) 
	<- 	!getBolts(500).
		//!constructChassis(X,Y).

+!getBolts(Amount): true
	<- 	!askAllProviders(Amount);
		!chooseBestDeal.

+!askAllProviders(Amount) : true
	<- 	for(boltProvider(P))
		{
			.send(P, achieve, priceEstimate(Amount));
		};
		.wait(500).

+!chooseBestDeal : deal(Amount, BestPrice)[source(Provider)] & not (deal(Amount, Price) & Price < BestPrice)
	<- 	.send(Provider, achieve, deliverBolts(Amount));
		for(deal(Amount,Price)[source(S)])
		{
			-deal(Amount,Price)[source(S)];
		}.

+deliveredBolts(Amount)[source(Provider)]: chassisNeeded(Type, Id)
	<- 	.print("Oh my god I got ", Amount, " awesome bolts from ", Provider);
		!constructChassis(Type, Id);
		-deliveredBolts(Amount)[source(Provider)].

+!constructChassis(X,Y) : true
	<-	.wait(500);
		.print("I constructed chassis ", X, ",", Y);
		!paintChassis(X,Y).	
		
+!paintChassis(X,Y) : true 
	<-	.send(painter,tell,paintChassisNeeded(X,Y)).

//////////////////////////////

+chassisPainted(X,Y)[source(Painter)] : chassisNeeded(X,Y)[source(S)]
	<- 	.send(qualityCheck,tell,chassisReady(X,Y));
		-chassisPainted(X,Y)[source(Painter)];
		-chassisNeeded(X,Y)[source(S)].