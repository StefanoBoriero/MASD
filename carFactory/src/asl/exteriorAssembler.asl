// Agent exteriorAssembler in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+exteriorAssemblyNeeded(X) 
	<- 	!assemblyExterior(X).

+!assemblyExterior(X) : true
	<-	.wait(500);
		.print("I assembled exterior ",X);
		.send(tester,tell,exteriorAssemblyReady(X)).	
		

