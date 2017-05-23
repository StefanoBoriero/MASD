// Agent exteriorAssembler in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+exteriorAssemblyNeeded(X,Y) 
	<- 	!assemblyExterior(X,Y).

+!assemblyExterior(X,Y) : true
	<-	.wait(500);
		.print("I assembled exterior ",X, ",", Y);
		.send(tester,tell,exteriorAssemblyReady(X,Y)).	
		

