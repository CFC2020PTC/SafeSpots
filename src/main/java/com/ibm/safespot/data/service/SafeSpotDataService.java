/**
 * 
 */
package com.ibm.safespot.data.service;

import com.cloudant.client.api.model.Response;
import com.ibm.safespot.model.SafeSpot;
import com.ibm.safespot.util.SafeSpotException;

/**
 * @author PrabhatKumar
 *
 */
public class SafeSpotDataService extends _ServiceManager{
	
	public void saveSafeSpot (SafeSpot safeSpot) throws SafeSpotException {
		Response response = save(safeSpot);
		if (response.getStatusCode() != 200) {
			throw new SafeSpotException("Unable to save the safeSpot");
		}
	}
	
	
}
