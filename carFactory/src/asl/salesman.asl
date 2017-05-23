// Agent sample_agent in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true 
	<-	sellCars.
		
	
+carOrdered(X,Y) : true
	<-	.print("Car ", X, ",", Y, " is ordered ");
		.send(scheduler,tell,carOrdered(X,Y)).

+carDelivered(X, Y) : true
	<- 	carSold(X,Y);
		.print("######################Car sold ",X, ",", Y).
		