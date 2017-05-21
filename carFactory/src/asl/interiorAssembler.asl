// Agent interiorAssembler in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+interiorAssemblyNeeded(X) 
	<- 	!assemblyInterior(X).

+!assemblyInterior(X) : true
	<-	.wait(500);
		.print("I assembled interior ",X);
		.send(tester,tell,interiorAssemblyReady(X)).