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
	 * Get the api-key from config.properties file.
	 * 
	 * @return {String} api-key.
	 */
	public static String getDiscoveryAPIKey() {
		return properties.getProperty("DISCOVERY_API_KEY");
	}
	
	/**
	 * Get the service url from config.properties file.
	 * 
	 * @return {String} service url.
	 */
	public static String getDiscoveryServiceUrl() {
		return properties.getProperty("DISCOVERY_SERVICE_URL");
	}
	
	/**
	 * Get the environment Id from config.properties file.
	 * 
	 * @return {String} environment Id.
	 */
	public static String getEnvironmentId() {
		return properties.getProperty("ENVIRONMENT_ID");
	}
	
	/**
	 * Get the collection id from config.properties file.
	 * 
	 * @return {String} collection id.
	 */
	public static String getCollectionId() {
		return properties.getProperty("COLLECTION_ID");
	}
	
	/**
	 * Get the version date from config.properties file.
	 * 
	 * @return {String} version date.
	 */
	public static String getVersionDate() {
		return properties.getProperty("VERSION_DATE");
	}

}
