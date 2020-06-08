package com.ibm.safespot.service;

import java.util.HashSet;
import java.util.Set;

import javax.ws.rs.core.Application;

import com.ibm.safespot.service.SafeSpotAPI;

/**
 * Application Manager class will hold all the rest services.
 * @author <a href="mailto:prabhat.kumar@in.ibm.com">Prabhat Kumar</a>
 */
public class ApplicationManager extends Application {
	
	/* (non-Javadoc)
	 * @see javax.ws.rs.core.Application#getClasses()
	 */
	@Override
	public Set<Class<?>> getClasses() {
		Set<Class<?>> classes = new HashSet<Class<?>>();
		classes.add(SafeSpotAPI.class);
		return classes;
	}
}
