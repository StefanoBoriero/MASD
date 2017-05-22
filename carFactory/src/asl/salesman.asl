// Agent sample_agent in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true 
	<- 	sellCars.
	
+carOrdered(X) : true
	<-	.print("Car ",X ," is ordered ");
		.send(scheduler,tell,carOrdered(X));
		-carOrdered(X).

