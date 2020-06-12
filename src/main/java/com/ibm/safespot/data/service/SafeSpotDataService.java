/**
 * 
 */
package com.ibm.safespot.data.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.ibm.safespot.model.SafeSpot;
import com.ibm.safespot.model.SafeSpotReviews;
import com.ibm.safespot.to.SafeSpotsTO;
import com.ibm.safespot.util.SafeSpotException;
import com.ibm.watson.discovery.v1.model.QueryResponse;
import com.ibm.watson.discovery.v1.model.QueryResult;

/**
 * @author PrabhatKumar
 *
 */
public class SafeSpotDataService extends _ServiceManager{
	
	public Map<String, Integer> getAllResults(String query) throws SafeSpotException {
		Map<String, Integer> categories = new LinkedHashMap<String, Integer>();
		
		QueryResponse queryResponse = getQuerySearchResult(query);
		List<QueryResult> results = queryResponse.getResults();
		for (QueryResult queryResult : results) {
			String category = (String) queryResult.get("type");
			if (categories.containsKey(category)) {
				categories.put(category, categories.get(category) +1);
			} else {
				categories.put(category, 1);
			}
		}
		return categories;
	}
	
	@SuppressWarnings("unchecked")
	public SafeSpotsTO getCategoriesByCategory(String city, String type){
		SafeSpotsTO safeSpotsTO = new SafeSpotsTO();
		List<SafeSpot> safeSpots = new ArrayList<SafeSpot>();
		QueryResponse queryResponse = getQuerySearchResult(city, type);
		List<QueryResult> results = queryResponse.getResults();
		for (QueryResult queryResult : results) {
			SafeSpot safeSpot = new SafeSpot();
			safeSpot.setCity((String) queryResult.get("city"));
			safeSpot.setName((String) queryResult.get("name"));
			safeSpot.setLatLong((String) queryResult.get("LatLong"));
			safeSpot.setType((String) queryResult.get("type"));
			
			safeSpot.setAddress((String) queryResult.get("address"));
			safeSpot.setOverAllsanitization((Number) queryResult.get("overAllsanitization"));
			safeSpot.setOverAlltemperature_sensor((Number) queryResult.get("overAlltemperature_sensor"));
			safeSpot.setOverAllsocial_distancing((Number) queryResult.get("overAllsocial_distancing"));
			safeSpot.setOverAllmask((Number) queryResult.get("overAllmask"));
			safeSpot.setOverAllRating((Number) queryResult.get("overAllRating"));

			safeSpot.setSaftyReview((ArrayList<SafeSpotReviews>) queryResult.get("safty_review"));
			safeSpots.add(safeSpot);
		}
		safeSpotsTO.setSafeLocData(safeSpots);
		return safeSpotsTO;
	}
	
	@SuppressWarnings("unchecked")
	public SafeSpotsTO getCategoriesByCategory(String city){
		SafeSpotsTO safeSpotsTO = new SafeSpotsTO();
		List<SafeSpot> safeSpots = new ArrayList<SafeSpot>();
		QueryResponse queryResponse = getQuerySearchResult(city);
		List<QueryResult> results = queryResponse.getResults();
		for (QueryResult queryResult : results) {
			SafeSpot safeSpot = new SafeSpot();
			safeSpot.setCity((String) queryResult.get("city"));
			safeSpot.setName((String) queryResult.get("name"));
			safeSpot.setLatLong((String) queryResult.get("LatLong"));
			safeSpot.setType((String) queryResult.get("type"));
			
			safeSpot.setAddress((String) queryResult.get("address"));
			safeSpot.setOverAllsanitization((Number) queryResult.get("overAllsanitization"));
			safeSpot.setOverAlltemperature_sensor((Number) queryResult.get("overAlltemperature_sensor"));
			safeSpot.setOverAllsocial_distancing((Number) queryResult.get("overAllsocial_distancing"));
			safeSpot.setOverAllmask((Number) queryResult.get("overAllmask"));
			safeSpot.setOverAllRating((Number) queryResult.get("overAllRating"));

			safeSpot.setSaftyReview((ArrayList<SafeSpotReviews>) queryResult.get("safty_review"));
			safeSpots.add(safeSpot);
		}
		safeSpotsTO.setSafeLocData(safeSpots);
		return safeSpotsTO;
	}
	
}
