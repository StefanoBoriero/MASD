// Agent painter in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+paintChassisNeeded(X) : true 
	<- 	!paintChassis(X).
	
+!paintChassis(X) : true 
	<- 	.wait(500);
		.print("I painted chassis ",X);
		.send(chassisAssembler,tell,chassisPainted(X)).
