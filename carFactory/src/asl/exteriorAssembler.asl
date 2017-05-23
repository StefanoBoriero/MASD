// Agent exteriorAssembler in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+exteriorReassemblyNeeded(X,Y)[source(tester)]
	<- 	.print("Exterior assembly needed!");
		//.send(tester,untell,exteriorAssemblyReady(X,Y));
		!assembleExterior(X,Y).

+!assembleExterior(X,Y) : true
	<-	.wait(500);
		.print("I assembled exterior ",X, ",", Y);
		-exteriorReassemblyNeeded(X,Y)[source(tester)];
		.send(tester,tell,exteriorAssemblyReady(X,Y)).	
		
		

