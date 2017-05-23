// Agent qualityChek in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+chassisReady(X,Y) : driveTrainReady(X,Y)
	<- !concatenate(X,Y).
	
+driveTrainReady(X,Y) : chassisReady(X,Y)
	<- !concatenate(X,Y).

+!concatenate(X,Y) : true
	<-	.wait(500);
		.print("I concatenated chassis ", X, ",", Y, " and drive train ",X, ",", Y);
		!assembleInteriorParts(X,Y);
		!assembleExteriorParts(X,Y).

+!assembleInteriorParts(X,Y) : true
	<-	.send(interiorAssembler,tell,interiorAssemblyNeeded(X,Y)).
	
+!assembleExteriorParts(X,Y) : true
	<-	.send(exteriorAssembler,tell,exteriorAssemblyNeeded(X,Y)).