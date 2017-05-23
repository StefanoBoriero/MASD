// Agent chassisAssembler in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

/////////////////////////////

+chassisNeeded(X,Y) 
	<- 	!constructChassis(X,Y).

+!constructChassis(X,Y) : true
	<-	.wait(500);
		.print("I constructed chassis ", X, ",", Y);
		!paintChassis(X,Y).		
		
+!paintChassis(X,Y) : true 
	<-	.send(painter,tell,paintChassisNeeded(X,Y)).

//////////////////////////////

+chassisPainted(X,Y)
	<- .send(qualityCheck,tell,chassisReady(X,Y));
		-chassisNeeded(X,Y).