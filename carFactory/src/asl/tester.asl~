// Agent tester in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+exteriorAssemblyReady(X,Y) : interiorAssemblyReady(X,Y)
	<- !testCar(X,Y).

+interiorAssemblyReady(X,Y) : exteriorAssemblyReady(X,Y)
	<- !testCar(X,Y).
	
+!testCar(X,Y) : true
	<- 	.wait(500);
		.print("I tested car ",X, ",", Y);
		!deliverCar(X,Y).
		
+!deliverCar(X,Y) : true
	<-	.print("######################Car delivered ",X, ",", Y).