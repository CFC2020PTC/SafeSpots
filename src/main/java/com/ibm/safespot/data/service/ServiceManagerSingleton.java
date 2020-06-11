/**
 * 
 */
package com.ibm.safespot.data.service;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map.Entry;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.cloudant.client.api.ClientBuilder;
import com.cloudant.client.api.CloudantClient;
import com.cloudant.client.api.Database;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ibm.safespot.util.Constants;
import com.ibm.safespot.util.SafeSpotException;
import com.ibm.safespot.util.Utility;

/**
 * @author PrabhatKumar
 *
 */
public class ServiceManagerSingleton {

	private static final Logger logger = Logger.getLogger(ServiceManagerSingleton.class.getName());
	// Saas Capabilities database connection.
	private static Database safeSpotDatabase = null;
	
	// Database user name.
	private static String userName;
	
	// Database password.
	private static String password;
	
	// Number of connections to the Cloudant Db
	private static final int MAX_CONNECTIONS = 100;
	
	// Database host name.
	private static String host;
	
	private static ServiceManagerSingleton instance;
	 
    private ServiceManagerSingleton() {
    }
	
    /**
	 * Get the instance for ServiceManagerSingleton
	 * @return instance information
	 */
	public static synchronized ServiceManagerSingleton getInstance() {
		if (instance == null) {
			instance = new ServiceManagerSingleton();
			initForServer();
		}
		return instance;
	}
	

	private static void initForServer() {
    	try {
    		long start = System.currentTimeMillis();
    		setSaaSCapabilitiesDatabase();
			// Read VCAP services from server.
			processVCAPServices();
			long total = System.currentTimeMillis() - start;
			logger.log(Level.FINEST, "ServiceManagerSingleton | initForServer total: " + total);
    	} catch (Exception e) {
    		logger.log(Level.SEVERE, "Error establishing Cumulus VCAP services. Please try again.", e);
    		// Reset the singleton to null since there was some issue establishing VCAP services.
    		instance = null;
    	}
    }

	/**
	 * Get cloudant data base url.
	 * 
	 * @param host
	 *            {String} host name
	 * @return {URL} url of cloudant database
	 * @throws MalformedURLException
	 */
	private static URL getHostUrl(String host) throws MalformedURLException {
		URL hostURL = new URL("https://" + host);
		return hostURL;
	}

	/**
	 * Process VCAP service will get the environment variable like user name,
	 * password and host name from .env file. If exists, process the
	 * VCAP_SERVICES environment variable in order to get
	 * @throws SaaSException 
	 */
	private static void processVCAPServices() throws SafeSpotException {
		logger.info("processVCAPServices");

		// VCAP_SERVICES is a system environment variable
		String VCAP_SERVICES = System.getenv("VCAP_SERVICES");

		String serviceName = null;
		// VCAP_SERVICE is not null, parse it to get the details.
		if (VCAP_SERVICES != null) {
			// parse the VCAP JSON structure
			JsonObject obj = (JsonObject) new JsonParser().parse(VCAP_SERVICES);
			Set<Entry<String, JsonElement>> entries = obj.entrySet();
			// Look for the VCAP key that holds cloudant information.
			for (Entry<String, JsonElement> entry : entries) {
				if (entry.getKey().contains(Constants.CLOUDANT_NO_SQL_DB)) {
					if (entry.getKey().startsWith(Constants.SAFE_SPOT_CLOUDANT_NO_SQL_DB)) {
						logger.info("key: " + entry.getKey());
						obj = (JsonObject) ((JsonArray) entry.getValue()).get(0);
						serviceName = (String) entry.getKey();
						logger.info("serviceName: " + serviceName);
						obj = (JsonObject) obj.get("credentials");
						userName = obj.get("username").getAsString();
						password = obj.get("password").getAsString();
						host = obj.get("host").getAsString();
						logger.info("username = " + userName);
						logger.info("host = " + host);
					}
				}
			}
		} else { // If VCAP_SERVICE is not found throw an exception.
			throw new SafeSpotException("VCAP_SERVICES not found");
		}
	}
	
	/**
	 * @return the safeSpotDatabase
	 */
	public Database getSafeSpotDatabase() {
		return safeSpotDatabase;
	}
	
	/**
	 * @param safeSpotDatabase
	 *            the safeSpotDatabase to set
	 * @throws SaaSException 
	 */
	private static void setSaaSCapabilitiesDatabase() throws SafeSpotException {
		String safeSpotDatabaseName = Utility.getSafeSpotDatabase();
		safeSpotDatabase = getCloudantDatabase(host, userName, password, safeSpotDatabaseName);
	}
	
	/**
	 * Get cloudant database instance.
	 * 
	 * @param host
	 *            {String} host name
	 * @param userName
	 *            {String} user name
	 * @param password
	 *            {String} password
	 * @param databaseName
	 *            {String} database name.
	 * @return {com.cloudant.client.api.Database} cloudant database
	 * @throws SaaSException 
	 * @throws MalformedURLException
	 */
	private static Database getCloudantDatabase(String host, String userName, String password, String databaseName) throws SafeSpotException {
		CloudantClient client = null;
		try {
			client = ClientBuilder.url(getHostUrl(host)).username(userName).password(password).maxConnections(MAX_CONNECTIONS).build();
		} catch (MalformedURLException mue) {
			// If the URL for database connection is not correct throw an exception.
			throw new SafeSpotException("Unable to establish a connection to the Cloudant database.", mue);
		}

		return client.database(databaseName, false);
	}
	
	/**
	 * @return the userName
	 */
	public String getUserName() {
		return userName;
	}

	/**
	 * @param userName the userName to set
	 */
	public void setUserName(String userName) {
		ServiceManagerSingleton.userName = userName;
	}

	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		ServiceManagerSingleton.password = password;
	}

	/**
	 * @return the host
	 */
	public String getHost() {
		return host;
	}

	/**
	 * @param host the host to set
	 */
	public void setHost(String host) {
		ServiceManagerSingleton.host = host;
	}
}
