package com.ibm.safespot.data.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import com.ibm.safespot.util.Constants;


/**
 * Base class for all data service classes.
 * 
 * @author <a href="mailto:prabhat.kumar@in.ibm.com">Prabhat Kumar</a>
 *
 */
public abstract class _ServiceManager {

	
	
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
