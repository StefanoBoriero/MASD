// Agent painter in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+paintChassisNeeded(X,Y) : true 
	<- 	!paintChassis(X,Y).
	
+!paintChassis(X,Y) : true 
	<- 	.wait(500);
		.print("I painted chassis ",X, ",", Y);
		.send(chassisAssembler,tell,chassisPainted(X,Y)).
