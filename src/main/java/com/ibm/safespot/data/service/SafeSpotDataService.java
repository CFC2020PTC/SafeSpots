/**
 * 
 */
package com.ibm.safespot.data.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
	
	
}
