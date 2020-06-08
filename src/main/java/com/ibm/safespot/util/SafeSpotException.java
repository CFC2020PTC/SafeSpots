package com.ibm.safespot.util;

import java.io.Serializable;

public class SafeSpotException extends Exception implements Serializable {
	private static final long serialVersionUID = 777237431556751949L;
	private int statusCode = 500;
	
	public SafeSpotException() {
        super();
    }
	
	public int getStatusCode() {
		return statusCode;
	}
	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}
	
    public SafeSpotException(String msg) {
        super(msg);
    }
    
    public SafeSpotException( int statusCode, String msg) {
        super(msg);
        this.statusCode = statusCode;
    }
    
    public SafeSpotException(String msg, Exception e) {
        super(msg, e);
    }
}