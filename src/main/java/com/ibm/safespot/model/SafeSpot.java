/**
 * 
 */
package com.ibm.safespot.model;

import java.util.List;

import com.google.gson.annotations.SerializedName;

/**
 * @author PrabhatKumar
 *
 */
public class SafeSpot {
	@SerializedName("name")
	private String name;
	@SerializedName("type")
	private String type;
	@SerializedName("LatLong")
	private String LatLong;
	@SerializedName("city")
	private String city;
	@SerializedName("safty_review")
	private List<SafeSpotReviews> saftyReview;
	
	public List<SafeSpotReviews> getSaftyReview() {
		return saftyReview;
	}
	public void setSaftyReview(List<SafeSpotReviews> saftyReview) {
		this.saftyReview = saftyReview;
	}
	/**
	 * @return the latLong
	 */
	public String getLatLong() {
		return LatLong;
	}
	/**
	 * @param latLong the latLong to set
	 */
	public void setLatLong(String latLong) {
		LatLong = latLong;
	}
	/**
	 * @return the city
	 */
	public String getCity() {
		return city;
	}
	/**
	 * @param city the city to set
	 */
	public void setCity(String city) {
		this.city = city;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}
}
