// Agent tester in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+exteriorAssemblyReady(X) : interiorAssemblyReady(X)
	<- !testCar(X).

+interiorAssemblyReady(X) : exteriorAssemblyReady(X)
	<- !testCar(X).
	
+!testCar(X) : true
	<- 	.wait(500);
		.print("I tested car ",X);
		!deliverCar(X).
		
+!deliverCar(X) : true
	<-	.print("Car delivered ",X).