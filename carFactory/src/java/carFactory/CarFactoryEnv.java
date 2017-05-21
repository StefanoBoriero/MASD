package carFactory;

import jason.environment.Environment;
import jason.asSyntax.*;
import jason.environment.*;
import java.util.logging.*;

public class CarFactoryEnv extends Environment {
	
	  private Logger logger = Logger.getLogger("carFactory.mas2j."+CarFactoryEnv.class.getName());


	 @Override
	  public void init(String[] args) {    }

	  @Override
	  public boolean executeAction(String agName, Structure action) {
	    if (action.getFunctor().equals("chooseCar")) {
	      addPercept(Literal.parseLiteral("carOrdered(1)"));
	      return true;
	    } else {
	      logger.info("executing: "+action+", but not implemented!");
	      return false;
	    }
	  }

	  /** Called before the end of MAS execution */
	  @Override
	  public void stop() {
	    super.stop();
	  }
}
