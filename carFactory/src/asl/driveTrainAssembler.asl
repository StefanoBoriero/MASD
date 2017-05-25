// Agent driveTrainAssembler in project carFactory

/* Initial beliefs and rules */

boltProvider(boltProviderA).
boltProvider(boltProviderB).
cfp(0).

/* Initial goals */

/* Plans */


+driveTrainNeeded(X,Y) 
	<- 	!getBolts(300).
		//!constructDriveTrain(X,Y).

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
			.send(P, tell, cfp(Id, driveTrainAssembler, Amount));
		}.
		
+!chooseBestProposal : proposal(Id, Amount, BestPrice)[source(Provider)] & not (proposal(Id, Amount, Price) & Price < BestPrice)
	<- 	.send(Provider, tell, accepted_proposal(Id, driveTrainAssembler));
		.print("Accepting proposal ", Id, " from ", Provider);
		-proposal(Id,Amount,BestPrice)[source(Provider)];
		for(proposal(Id,_,_)[source(S)])
		{
			.print("Refusing proposal ", Id, " from ", S);
			.send(S, tell, refused_proposal(Id, driveTrainAssembler));
			-proposal(Id,_,_)[source(S)];
		}.

+!chooseBestProposal : not(proposal(_,_,_) )
	<- .print("Nobody has enough bolts... let's wait some time");
		.wait(1000);
		!getBolts(300).		

+deliveredBolts(Amount)[source(Provider)]: driveTrainNeeded(Type, Id)
	<- 	.print("Oh my god I got ", Amount, " awesome bolts from ", Provider);
		!constructDriveTrain(Type, Id);
		-deliveredBolts(Amount)[source(Provider)].

+!constructDriveTrain(X,Y) : true
	<-	.wait(500);
		.print("I constructed drive train ", X, ",", Y);
		.send(qualityCheck,tell,driveTrainReady(X,Y)).	
		
