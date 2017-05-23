// Agent boltProvider in project carFactory

/* Initial beliefs and rules */

boltsLeft(1000).
pricePerBolt(0.05).


/* Initial goals */

/* Plans */
+!deliverBolts(Amount)[source(S)]: boltsLeft(N) & N >= Amount
 <- NewBoltsLeft = N - Amount;
 	-boltsLeft(N);
 	+boltsLeft(NewBoltsLeft);
	.send(S, tell, deliveredBolts(Amount)).
	
+!deliverBolts(Amount)[source(S)]: boltsLeft(N) & N < Amount
 	<- .print("OUT OF BOLTS").
 
+!priceEstimate(Amount)[source(Applicant)]: pricePerBolt(P) & boltsLeft(N) & N >= Amount
	<- 	Price = P * Amount;
		.send(Applicant, tell, deal(Amount, Price)).

+!priceEstimate(Amount)[source(Applicant)]: boltsLeft(N) & N < Amount
	<- 	.send(Applicant, tell, outOfBolts(boltProviderA)).

