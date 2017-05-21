// Agent sample_agent in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true 
	<- 	chooseCar.
	
+carOrdered(X) : true
	<-	.print("Car ",X ," is ordered ");
		.send(scheduler,tell,carOrdered(X)).

