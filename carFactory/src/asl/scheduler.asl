// Agent scheduler in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+carOrdered(X,Y) : true 
	<- !startCar(X,Y).

+!startCar(X,Y) : true 
	<- 	.send(chassisAssembler,tell,chassisNeeded(X,Y));
		.send(driveTrainAssembler,tell,driveTrainNeeded(X,Y)).