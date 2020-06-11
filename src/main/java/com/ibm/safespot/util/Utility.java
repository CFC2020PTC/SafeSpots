package com.ibm.safespot.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Utility class for reading cofig.properties file.
 * 
 * @author <a href="mailto:prabhat.kumar@in.ibm.com">Prabhat Kumar</a>
 *
 */
public class Utility {
	
	// Properties which contains database names
	private static Properties properties = new Properties();
	private static Logger logger = Logger.getLogger(Utility.class.getName());
	
	// Read config.properties and load in properties.
	static {
		InputStream inputStream = Utility.class.getResourceAsStream("resources/config.properties");
		try {
			properties.load(inputStream);
		} catch (IOException ioException) {
			logger.log(Level.SEVERE, ioException.getMessage());
			throw new RuntimeException("Unable to load config.properties file.");
		} finally {
			try {
				inputStream.close();
			} catch (IOException e) {
				logger.log(Level.SEVERE, e.getMessage());
			}
		}
	}


	/**
	 * Get the environment from config.properties file.
	 * 
	 * @return {String} environment name.
	 */
	public static String getEnvironment() {
		return properties.getProperty("ENVIRONMENT");
	}
	
	/**
	 * Get the Database from config.properties file.
	 * 
	 * @return {String} database name.
	 */
	public static String getSafeSpotDatabase() {
		return properties.getProperty("SAFE_SPOTS_DATABASE");
	}
	

}
