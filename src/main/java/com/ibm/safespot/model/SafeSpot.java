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
	
	@SerializedName("address")
	private String address;
	
	@SerializedName("overAllsanitization")
	private Number overAllsanitization;
	@SerializedName("overAlltemperature_sensor")
	private Number overAlltemperature_sensor;
	@SerializedName("overAllsocial_distancing")
	private Number overAllsocial_distancing;
	@SerializedName("overAllmask")
	private Number overAllmask;
	@SerializedName("overAllRating")
	private Number overAllRating;
	
	@SerializedName("safty_review")
	private List<SafeSpotReviews> saftyReview;
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
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
	public Number getOverAllsanitization() {
		return overAllsanitization;
	}
	public void setOverAllsanitization(Number overAllsanitization) {
		this.overAllsanitization = overAllsanitization;
	}
	public Number getOverAlltemperature_sensor() {
		return overAlltemperature_sensor;
	}
	public void setOverAlltemperature_sensor(Number overAlltemperature_sensor) {
		this.overAlltemperature_sensor = overAlltemperature_sensor;
	}
	public Number getOverAllsocial_distancing() {
		return overAllsocial_distancing;
	}
	public void setOverAllsocial_distancing(Number overAllsocial_distancing) {
		this.overAllsocial_distancing = overAllsocial_distancing;
	}
	public Number getOverAllmask() {
		return overAllmask;
	}
	public void setOverAllmask(Number overAllmask) {
		this.overAllmask = overAllmask;
	}
	public Number getOverAllRating() {
		return overAllRating;
	}
	public void setOverAllRating(Number overAllRating) {
		this.overAllRating = overAllRating;
	}
}
