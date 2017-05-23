package carFactory;

import jason.environment.Environment;
import jason.stdlib.add_plan;
import jason.asSyntax.*;
import jason.environment.*;

import java.util.List;
import java.util.Collection;
import java.util.Random;
import java.util.logging.*;


public class CarFactoryEnv extends Environment {

	private Logger logger = Logger.getLogger("carFactory.mas2j."+CarFactoryEnv.class.getName());

	@Override
	public void init(String[] args) {    }

	@Override
	public boolean executeAction(String agName, Structure action) {	
		
		logger.info("executeAction " + action);
		
		if (action.getFunctor().equals("sellCars")) {			
			return sellCars();
			
		} else if (action.getFunctor().equals("carSold")) {
			return carSold(action);
			
		} else if (action.getFunctor().equals("testCar")) {
			return testCar(action);
		} else {
			logger.info("executing: "+action+", but not implemented!");
			return false;
		}
	}
	
	private boolean testCar(Structure action) {
		logger.info("testCar " + action.toString());
		
		
		String X = action.getTerm(0).toString();
		int Y = Integer.parseInt(action.getTerm(1).toString());
		
		Random r = new Random();
		int n = r.nextInt(101);
		
		int result = 0;
		//logger.info(" "+Math.abs(Constants.RATE_PASS + Constants.RATE_INTERIOR_FAIL + Constants.RATE_EXTERIOR_FAIL + Constants.RATE_BOTH_FAIL));
		if (Math.abs(Constants.RATE_PASS + Constants.RATE_INTERIOR_FAIL + Constants.RATE_EXTERIOR_FAIL + Constants.RATE_BOTH_FAIL - 1.0) > 0.000001)
			throw new IllegalArgumentException("Test rates do not sum to one!"); 
		
		if (0 <= n && n < Constants.RATE_PASS * 100) 
			// Pass
			result = 0;
		else if (Constants.RATE_PASS * 100 <= n && n < (Constants.RATE_PASS + Constants.RATE_INTERIOR_FAIL) * 100) 
			// Interior fail
			result = 1;
		else if ((Constants.RATE_PASS + Constants.RATE_INTERIOR_FAIL) * 100 <= n && n <  (Constants.RATE_PASS + Constants.RATE_INTERIOR_FAIL + Constants.RATE_EXTERIOR_FAIL) * 100) 
			// Exterior fail
			result = 2;
		else if ((Constants.RATE_PASS + Constants.RATE_INTERIOR_FAIL + Constants.RATE_EXTERIOR_FAIL) * 100 <= n && n <= 100)
			// Exterior and interior fail
			result = 3;
		
		
		//Literal literal = Literal.parseLiteral(action.toString().replace("testCar", "testResult"));	
        Literal literal = ASSyntax.createLiteral("testResult",
                ASSyntax.createLiteral(X),
                ASSyntax.createNumber(Y),
				ASSyntax.createNumber(result));
				
				
		logger.info("sending " + literal + " to tester");
		addPercept("tester",literal);
		return true;
	}	
	
	
	private boolean carSold(Structure action) {
		logger.info("carsold " + action.toString());
		Literal literal = Literal.parseLiteral(action.toString().replace("carSold", "carOrdered"));	
		logger.info("remove percept " + literal.toString());
		removePercept("salesman",literal);
		return true;
	}
	
	private boolean sellCars() {	
		Random rand = new Random();
		DatabaseUtils db = new DatabaseUtils(logger);
		List<String> cars = db.GetCars();
		
		int carsOrdered = 0;
		while(carsOrdered <= Constants.CAR_COUNT) {		
			
			String c = cars.get(rand.nextInt(cars.size()));
			String litString = "carOrdered(" + c + "," + carsOrdered + ")";
			Literal literal = Literal.parseLiteral(litString);
			logger.info("sending " + litString + " to salesman");
			addPercept("salesman",literal);	
            try {
				Thread.sleep(Constants.CAR_DELAY);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			carsOrdered++;
		}			
		logger.info("Done taking orders cars!");
		return true;
	}

	
	
	/** Called before the end of MAS execution */
	@Override
	public void stop() {
		super.stop();
	}
}
