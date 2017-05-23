// Agent interiorAssembler in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+interiorAssemblyNeeded(X,Y) 
	<- 	!assemblyInterior(X,Y).

+!assemblyInterior(X,Y) : true
	<-	.wait(500);
		.print("I assembled interior ",X, ",", Y);
		.send(tester,tell,interiorAssemblyReady(X,Y)).