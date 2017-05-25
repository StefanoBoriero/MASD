// Agent boltProvider in project carFactory

/* Initial beliefs and rules */

boltsLeft(1000).
pricePerBolt(0.05).


/* Initial goals */

!start.

/* Plans */

+!start : true
	<- 	?boltsLeft(B);
		+potentialBoltsLeft(B).

@processOrder[atomic]
+cfp(Id, Applicant, AmountOfBolts)[source(S)]: boltsLeft(N) & N >= AmountOfBolts & not(proposal(_,_,_,_))
	<- 	+proposal(Id, Applicant, AmountOfBolts, Price);
		?pricePerBolt(Ppb);
		Price = AmountOfBolts * Ppb;
		.print("Sending a proposal: ", AmountOfBolts, " bolts for ", Price, " euros to ", Applicant);
		.send(Applicant, tell, proposal(Id, AmountOfBolts, Price)).

+cfp(Id, Applicant, AmountOfBolts)[source(S)]: boltsLeft(N) & N < AmountOfBolts
	<- 	-cfp(Id, Applicant, AmountOfBolts)[source(S)];
		!refill;
		.print("Declining request from ", Applicant, " because I don't have enough bolts...");
		.send(Applicant, tell, refuse(Id)).

+cfp(Id, Applicant, AmountOfBolts)[source(S)]: boltsLeft(N) & N >= AmountOfBolts & proposal(_,_,_,_) & potentialBoltsLeft(PB)
	<- 	if(PB >= AmountOfBolts)
	 	{
	 		?pricePerBolt(Ppb);
			Price = AmountOfBolts * Ppb;
			+proposal(Id, Applicant, AmountOfBolts, Price);
			.print("Sending a proposal: ", AmountOfBolts, " bolts for ", Price, " euros to ", Applicant);
			.send(Applicant, tell, proposal(Id, AmountOfBolts, Price));
	 	}
	 	else
	 	{
	 		!refill;
	 		.print("Declining request from ", Applicant, " because I don't have enough bolts...")
			.send(Applicant, tell, refuse(Id));
	 	}.

+proposal(_, _, AmountOfBolts, _) : true
	<- 	?potentialBoltsLeft(PB);
		NewPB = PB - AmountOfBolts;
		-potentialBoltsLeft(PB);
		+potentialBoltsLeft(NewPB).

+accepted_proposal(Id, Applicant) : proposal(Id, Applicant, AmountOfBolts, Price)
	<-	?boltsLeft(Left);
		NewBoltsLeft = Left - AmountOfBolts;
		-boltsLeft(Left);
		+boltsLeft(NewBoltsLeft);
		//?cfp(Id,_)[source(_)];
		-proposal(Id, _, _);
		//-cfp(Id,_)[source(_)];
		.print(Applicant, " accepted the proposal ", Id, " :" , AmountOfBolts, " bolts for ", Price, " euros");
		.send(Applicant, tell, deliveredBolts(AmountOfBolts)).

+accepted_proposal(Id, Applicant) : not( proposal(Id, Applicant, AmountOfBolts, _) )
	<- .print("ACCEPTED PROPOSAL NOT FOUND").
	
+refused_proposal(Id, Applicant)[source(S)] : proposal(Id, Applicant, Amount, _)
	<-	.print("Refused Proposal ", Id, " from ", Applicant);
		?potentialBoltsLeft(PB);
		NewPB = PB + Amount;
		-potentialBoltsLeft(PB);
		+potentialBoltsLeft(NewPB);
		-proposal(Id, S, _, _);
		-refused_proposal(Id, Applicant)[source(S)];
		-cfp(Id, _).

+refused_proposal(Id, Applicant)[source(S)] : not(proposal(Id, Applicant, _, _))
	<-	.print("REFUSED PROPOSAL NOT FOUND").
		
+!refill : boltsLeft(B)
	<-	.print("Asking for new bolts...");
		.wait(500);
		?boltsLeft(B);
		?potentialBoltsLeft(PB);
		New = 1000;
		-boltsLeft(B);
		-potentialBoltsLeft(PB);
		+potentialBoltsLeft(New + PB);
		+boltsLeft(B + New).