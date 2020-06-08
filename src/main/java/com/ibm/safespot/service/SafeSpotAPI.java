package com.ibm.safespot.service;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.google.gson.Gson;
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

	/**
	 * Check the REST API is working with get call.
	 * 
	 * @return
	 * @throws SafeSpotException
	 */
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/check")
	public String checkRestAPI() throws SafeSpotException {
		return gson.toJson("true");
	}
}
