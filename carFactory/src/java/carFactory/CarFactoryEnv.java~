package carFactory;

import jason.environment.Environment;
import jason.stdlib.add_plan;
import jason.asSyntax.*;
import jason.environment.*;

import java.util.List;
import java.util.Random;
import java.util.logging.*;

public class CarFactoryEnv extends Environment {

	private Logger logger = Logger.getLogger("carFactory.mas2j."+CarFactoryEnv.class.getName());


	@Override
	public void init(String[] args) {    }

	@Override
	public boolean executeAction(String agName, Structure action) {	
		if (action.getFunctor().equals("sellCars")) {		
			return sellCars();
		} else {
			logger.info("executing: "+action+", but not implemented!");
			return false;
		}
	}

	private boolean sellCars() {	
		Random rand = new Random();
		DatabaseUtils db = new DatabaseUtils(logger);
		List<String> cars = db.GetCars();
		int i = 0;
		while(i < Constants.CAR_COUNT) {			
			String c = cars.get(rand.nextInt(cars.size()));
			String litString = "carOrdered(" + c + "," + i + ")";
			Literal literal = Literal.parseLiteral(litString);
			logger.info("sending " + litString + " to salesman");
			addPercept("salesman",literal);	
            try {
				Thread.sleep(Constants.CAR_DELAY);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			i++;
		}				
		return true;
	}

	/** Called before the end of MAS execution */
	@Override
	public void stop() {
		super.stop();
	}
}
