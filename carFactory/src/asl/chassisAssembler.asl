// Agent chassisAssembler in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

/////////////////////////////

+chassisNeeded(X) 
	<- 	!constructChassis(X).

+!constructChassis(X) : true
	<-	.wait(500);
		.print("I constructed chassis ", X);
		!paintChassis(X).		
		
+!paintChassis(X) : true 
	<-	.send(painter,tell,paintChassisNeeded(X)).

//////////////////////////////

+chassisPainted(X)
	<- .send(qualityCheck,tell,chassisReady(X)).