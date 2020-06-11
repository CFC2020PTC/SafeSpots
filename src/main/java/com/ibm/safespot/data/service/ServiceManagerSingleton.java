/**
 * 
 */
package com.ibm.safespot.data.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.ibm.cloud.sdk.core.security.IamAuthenticator;
import com.ibm.safespot.util.Constants;
import com.ibm.safespot.util.Utility;
import com.ibm.watson.discovery.v1.Discovery;

/**
 * @author PrabhatKumar
 *
 */
public class ServiceManagerSingleton {

	private static final Logger logger = Logger.getLogger(ServiceManagerSingleton.class.getName());
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
			init();
		}
		return instance;
	}
	

	private static void init() {
    	try {
    		long start = System.currentTimeMillis();
			long total = System.currentTimeMillis() - start;
			logger.log(Level.FINEST, "ServiceManagerSingleton | initForServer total: " + total);
    	} catch (Exception e) {
    		logger.log(Level.SEVERE, "Error establishing VCAP services. Please try again.", e);
    		// Reset the singleton to null since there was some issue establishing VCAP services.
    		instance = null;
    	}
    }

	/**
	 * Get Watson Discovery instance
	 * 
	 * @return {@link Discovery}
	 */
	public Discovery getDiscovery() {
		IamAuthenticator authenticator = new IamAuthenticator(Utility.getDiscoveryAPIKey());
		Discovery discovery = new Discovery(Utility.getVersionDate(), authenticator);
		discovery.setServiceUrl(Utility.getDiscoveryServiceUrl());
		return discovery;
	}
	
	
	/**
	 * Gets the current timestamp in GMT time
	 * 
	 * @return String of current timestamp
	 */
	public String getCurrentTimestamp() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(Constants.DATE_FORMAT);
		simpleDateFormat.setTimeZone(TimeZone.getTimeZone(Constants.TIMEZONE));
		return simpleDateFormat.format(new Date());
	}
}
