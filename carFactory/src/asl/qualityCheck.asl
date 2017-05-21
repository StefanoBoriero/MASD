// Agent qualityChek in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+chassisReady(X) : driveTrainReady(X)
	<- !concatenate(X).
	
+driveTrainReady(X) : chassisReady(X)
	<- !concatenate(X).

+!concatenate(X) : true
	<-	.wait(500);
		.print("I concatenated chassis ", X, " and drive train ",X);
		!assembleInteriorParts(X);
		!assembleExteriorParts(X).

+!assembleInteriorParts(X) : true
	<-	.send(interiorAssembler,tell,interiorAssemblyNeeded(X)).
	
+!assembleExteriorParts(X) : true
	<-	.send(exteriorAssembler,tell,exteriorAssemblyNeeded(X)).