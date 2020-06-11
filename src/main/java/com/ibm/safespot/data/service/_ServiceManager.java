package com.ibm.safespot.data.service;

import com.ibm.safespot.util.Utility;
import com.ibm.watson.discovery.v1.model.QueryOptions;
import com.ibm.watson.discovery.v1.model.QueryResponse;

/**
 * Base class for all data service classes.
 * 
 * @author <a href="mailto:prabhat.kumar@in.ibm.com">Prabhat Kumar</a>
 *
 */
public abstract class _ServiceManager {

	ServiceManagerSingleton serviceManagerSingleton = ServiceManagerSingleton.getInstance();
	
	protected QueryResponse getQuerySearchResult (String query) {
		QueryOptions.Builder queryBuilder = new QueryOptions.Builder(Utility.getEnvironmentId(), Utility.getCollectionId());
		queryBuilder.query(query).count(1000);
		QueryResponse queryResponse = serviceManagerSingleton.getDiscovery().query(queryBuilder.build()).execute().getResult();
		return queryResponse;
	}
	

}
