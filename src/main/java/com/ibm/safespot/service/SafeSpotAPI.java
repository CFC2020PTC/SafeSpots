package com.ibm.safespot.service;

import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.SecurityContext;

import com.google.gson.Gson;
import com.ibm.safespot.data.service.SafeSpotDataService;
import com.ibm.safespot.model.SafeSpot;
import com.ibm.safespot.util.SafeSpotException;

/**
 * Safe spot REST API class.
 * 
 * @author <a href="mailto:prabhat.kumar@in.ibm.com">Prabhat Kumar</a>
 *
 */
@Path("/safespots")
public class SafeSpotAPI {

	private Gson gson = new Gson();
	private SafeSpotDataService safeSpotDataService = new SafeSpotDataService(); 
	/**
	 * Check the SafeSpots.
	 * 
	 * @return
	 * @throws SafeSpotException
	 */
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/saveSafeSpot")
	public void saveSafeSpot(@Context SecurityContext securityContext, @FormParam("safespot") String safeSpotsJson) throws SafeSpotException {
		SafeSpot safeSpot = gson.fromJson(safeSpotsJson, SafeSpot.class);
		safeSpotDataService.saveSafeSpot(safeSpot);
	}
}
