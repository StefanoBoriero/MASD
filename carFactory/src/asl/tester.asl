// Agent tester in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+exteriorAssemblyReady(X,Y) : interiorAssemblyReady(X,Y)
	<- testCar(X,Y).
	
+interiorAssemblyReady(X,Y) : exteriorAssemblyReady(X,Y)
	<- testCar(X,Y).

+testResult(X,Y,Z) : Z = 0
	<- 	.wait(500);
		.print("I tested car ",X, ",", Y, "result: PASS!");
		//-testResult(X,Y,Z)[source(percept)];
		!deliverCar(X,Y).
		
+testResult(X,Y,Z) : Z = 1
	<- 	.wait(500);
		.print("I tested car ",X, ",", Y, "result: INTERIOR DEFECT!");
		-interiorAssemblyReady(X,Y)[source(interiorAssembler)];
		//-testResult(X,Y,Z)[source(percept)];
		.send(interiorAssembler,tell,interiorReassemblyNeeded(X,Y)).
		

+testResult(X,Y,Z) : Z = 2
	<- 	.wait(500);
		.print("I tested car ",X, ",", Y, "reslt : EXTERIOR DEFECT");
		-exteriorAssemblyReady(X,Y)[source(exteriorAssembler)];
		//-testResult(X,Y,Z)[source(percept)];
		.send(exteriorAssembler,tell,exteriorReassemblyNeeded(X,Y)).
		

+testResult(X,Y,Z) : Z = 3
	<- 	.wait(500);
		.print("I tested car ",X, ",", Y, "reslt : INTERIOR + EXTERIOR DEFECT");
		-interiorAssemblyReady(X,Y)[source(interiorAssembler)];
		-exteriorAssemblyReady(X,Y)[source(exteriorAssembler)];
		//-testResult(X,Y,Z)[source(percept)];
		.send(interiorAssembler,tell,interiorReassemblyNeeded(X,Y));
		.send(exteriorAssembler,tell,exteriorReassemblyNeeded(X,Y)).
		
+!deliverCar(X,Y) : true
	<-	-interiorAssemblyReady(X,Y)[source(interiorAssembler)];
		-exteriorAssemblyReady(X,Y)[source(exteriorAssembler)];
		.send(salesman,tell,carDelivered(X,Y)).