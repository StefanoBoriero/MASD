// Agent scheduler in project carFactory

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+carOrdered(X) : true 
	<- !startCar(X).

+!startCar(X) : true 
	<- 	.send(chassisAssembler,tell,chassisNeeded(X));
		.send(driveTrainAssembler,tell,driveTrainNeeded(X)).