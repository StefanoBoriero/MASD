package carFactory;

import jason.environment.Environment;
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
		if (action.getFunctor().equals("chooseCar")) {		
			return chooseCar();
		} else {
			logger.info("executing: "+action+", but not implemented!");
			return false;
		}
	}

	private boolean chooseCar() {
		Random rand = new Random();
		int i = 0;
		DatabaseUtils db = new DatabaseUtils(logger);
		List<String> cars = db.GetCars();
		while(i < Constants.CAR_COUNT) {
			String c = cars.get(rand.nextInt(cars.size()));
			String literal = "carOrdered(" + c + ")";
			logger.info("sending " + literal + " to salesman");
			addPercept("salesman",Literal.parseLiteral(literal));	
			i++;
            try {
				Thread.sleep(Constants.CAR_DELAY);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	/** Called before the end of MAS execution */
	@Override
	public void stop() {
		super.stop();
	}
}
