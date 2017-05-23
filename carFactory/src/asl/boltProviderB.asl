// Agent boltProviderB in project carFactory

/* Initial beliefs and rules */

boltsLeft(2000).
pricePerBolt(0.03).

/* Initial goals */


/* Plans */

+!deliverBolts(Amount)[source(S)]: boltsLeft(N) & N >= Amount
 <- NewBoltsLeft = N - Amount;
 	-boltsLeft(N);
 	+boltsLeft(NewBoltsLeft);
	.send(S, tell, deliveredBolts(Amount)).
	
+!priceEstimate(Amount)[source(Applicant)]: pricePerBolt(P) & boltsLeft(N) & N >= Amount
	<- 	Price = P * Amount;
		.send(Applicant, tell, deal(Amount, Price)).
		
+!priceEstimate(Amount)[source(Applicant)]: boltsLeft(N) & N < Amount
	<- 	!refill;
		.send(Applicant, tell, outOfBolts(boltProviderB)).

+!refill : boltsLeft(B)
	<-	.wait(2000);
		-boltsLeft(B);
		+boltsLeft(2000).
