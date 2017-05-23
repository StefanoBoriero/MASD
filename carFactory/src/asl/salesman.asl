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

+!carFinished(X, Y) : true
	<-	deliverCar(X,Y);
		.print("######################Car finished ",X, ",", Y).
		