// Agent interiorAssembler in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+interiorReassemblyNeeded(X,Y)[source(tester)]
	<- 	.print("Interior assembly needed!");
		//.send(tester,untell,interiorAssemblyReady(X,Y));
		!assembleInterior(X,Y).

+!assembleInterior(X,Y) : true
	<-	.wait(500);
		.print("I assembled interior ",X, ",", Y);
		-interiorReassemblyNeeded(X,Y)[source(tester)];
		.send(tester,tell,interiorAssemblyReady(X,Y)).