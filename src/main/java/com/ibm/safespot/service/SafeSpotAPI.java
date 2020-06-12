package com.ibm.safespot.service;

import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

import com.google.gson.Gson;
import com.ibm.safespot.data.service.SafeSpotDataService;
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
	 * Get the SafeSpots for given city.
	 * 
	 * @return
	 * @throws SafeSpotException
	 */
	@GET
	@Path("/getCategories")
	public String getCategories(@FormParam("city") String city) throws SafeSpotException {
		return gson.toJson(safeSpotDataService.getAllResults("city:"+city));
	}
	
	/**
	 * Get the SafeSpots for given city and category.
	 * 
	 * @return
	 * @throws SafeSpotException
	 */
	@GET
	@Path("/getCategoriesByCategory")
	public String getCategoriesByCategory(@FormParam("city") String city, @FormParam("category") String category) throws SafeSpotException {
		return gson.toJson(safeSpotDataService.getCategoriesByCategory("city:"+city, "type:"+category));
	}
	
	/**
	 * Get the SafeSpots for given city and category.
	 * 
	 * @return
	 * @throws SafeSpotException
	 */
	@GET
	@Path("/getCategoriesByCategory1")
	public String getCategoriesByCategory(@FormParam("city") String city) throws SafeSpotException {
		return gson.toJson(safeSpotDataService.getCategoriesByCategory("city:"+city));
	}
	
}
