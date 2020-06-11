/**
 * 
 */
package com.ibm.safespot.model;

import com.google.gson.annotations.SerializedName;

/**
 * @author PrabhatKumar
 *
 */
public class SafeSpotReviews {
	@SerializedName("name")
	private String name;
	@SerializedName("email")
	private String email;
	@SerializedName("sanitization")
	private boolean sanitization;
	@SerializedName("temperature_sensor")
	private boolean temperatureSensor;
	@SerializedName("social_distancing")
	private boolean socialDistancing;
	@SerializedName("mandatory")
	private boolean mandatory;
	@SerializedName("review_rating")
	private String reviewRating;
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
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the sanitization
	 */
	public boolean isSanitization() {
		return sanitization;
	}
	/**
	 * @param sanitization the sanitization to set
	 */
	public void setSanitization(boolean sanitization) {
		this.sanitization = sanitization;
	}
	/**
	 * @return the temperatureSensor
	 */
	public boolean isTemperatureSensor() {
		return temperatureSensor;
	}
	/**
	 * @param temperatureSensor the temperatureSensor to set
	 */
	public void setTemperatureSensor(boolean temperatureSensor) {
		this.temperatureSensor = temperatureSensor;
	}
	/**
	 * @return the socialDistancing
	 */
	public boolean isSocialDistancing() {
		return socialDistancing;
	}
	/**
	 * @param socialDistancing the socialDistancing to set
	 */
	public void setSocialDistancing(boolean socialDistancing) {
		this.socialDistancing = socialDistancing;
	}
	/**
	 * @return the mandatory
	 */
	public boolean isMandatory() {
		return mandatory;
	}
	/**
	 * @param mandatory the mandatory to set
	 */
	public void setMandatory(boolean mandatory) {
		this.mandatory = mandatory;
	}
	/**
	 * @return the review_comment
	 */
	public String getReview_comment() {
		return review_comment;
	}
	/**
	 * @param review_comment the review_comment to set
	 */
	public void setReview_comment(String review_comment) {
		this.review_comment = review_comment;
	}
	@SerializedName("review_comment")
	private String review_comment;
}
