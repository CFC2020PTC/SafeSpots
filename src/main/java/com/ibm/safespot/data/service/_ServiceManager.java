package com.ibm.safespot.data.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import com.cloudant.client.api.model.Response;
import com.ibm.safespot.model.SafeSpot;
import com.ibm.safespot.util.Constants;


/**
 * Base class for all data service classes.
 * 
 * @author <a href="mailto:prabhat.kumar@in.ibm.com">Prabhat Kumar</a>
 *
 */
public abstract class _ServiceManager {

	ServiceManagerSingleton serviceManagerSingleton = ServiceManagerSingleton.getInstance();
	
	/**
	 * Save the {@link Object} in database.
	 * @param object {@link Object}
	 * @return {@link Response}
	 */
	protected Response save (Object object) {
		return serviceManagerSingleton.getSafeSpotDatabase().save(object);
	}
	
	/**
	 * Update the {@link SafeSpot} in database.
	 * @param object {@link Object}
	 * @return {@link Response}
	 */
	protected Response update (Object object) {
		return serviceManagerSingleton.getSafeSpotDatabase().update(object);
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
