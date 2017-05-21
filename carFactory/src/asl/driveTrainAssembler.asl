// Agent driveTrainAssembler in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */


+driveTrainNeeded(X) 
	<- 	!constructDriveTrain(X).

+!constructDriveTrain(X) : true
	<-	.wait(500);
		.print("I constructed drive train ", X);
		.send(qualityCheck,tell,driveTrainReady(X)).	
		
