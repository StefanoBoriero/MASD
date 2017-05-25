// Agent chassisAssembler in project carFactory

/* Initial beliefs and rules */

boltProvider(boltProviderB).
boltProvider(boltProviderA).


cfp(0).

/* Initial goals */

/* Plans */

/////////////////////////////

+chassisNeeded(X,Y) 
	<- 	!getBolts(800).
		//!constructChassis(X,Y).

+!getBolts(Amount): true
	<- 	!askAllProviders(Amount);
		.wait(1000);
		!chooseBestProposal.

+!askAllProviders(Amount) : true
	<- 	?cfp(Id);
		NewId = Id + 1;
		-cfp(Id);
		+cfp(NewId);
		for(boltProvider(P))
		{
			.print("Asking ", P);
			.send(P, tell, cfp(Id, chassisAssembler, Amount));
		}.

+!chooseBestProposal : proposal(Id, Amount, BestPrice)[source(Provider)] & not (proposal(Id, Amount, Price) & Price < BestPrice)
	<- 	.send(Provider, tell, accepted_proposal(Id, chassisAssembler));
		.print("Accepting proposal ", Id, " from ", Provider);
		-proposal(Id,Amount,BestPrice)[source(Provider)];
		for(proposal(Id,_,_)[source(S)])
		{
			.print("Refusing proposal ", Id, " from ", S);
			.send(S, tell, refused_proposal(Id, chassisAssembler));
			-proposal(Id,_,_)[source(S)];
		}.

+!chooseBestProposal : not(proposal(_,_,_) )
	<- .print("Nobody has enough bolts... let's wait some time");
		.wait(1000);
		!getBolts(800).		

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