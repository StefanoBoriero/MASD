// Agent driveTrainAssembler in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */


+driveTrainNeeded(X,Y) 
	<- 	!constructDriveTrain(X,Y).

+!constructDriveTrain(X,Y) : true
	<-	.wait(500);
		.print("I constructed drive train ", X, ",", Y);
		.send(qualityCheck,tell,driveTrainReady(X,Y)).	
		
