package net.carting.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="admin_settings")
public class AdminSettings {
	
	@Id
	@Column(name = "id")
	@GeneratedValue
    private int id;
	
	@Column(name="parental_permission_years", nullable = false)
	private int parentalPermissionYears;
	
	@Column(name="points_by_places", nullable = false)
	private String pointsByPlaces;
	
	@Column(name="feedback_email", nullable = false)
	private String feedbackEmail;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getParentalPermissionYears() {
		return parentalPermissionYears;
	}

	public void setParentalPermissionYears(int parentalPermissionYears) {
		this.parentalPermissionYears = parentalPermissionYears;
	}

	public String getPointsByPlaces() {
		return pointsByPlaces;
	}

	public void setPointsByPlaces(String pointsByPlaces) {
		this.pointsByPlaces = pointsByPlaces;
	}

	public String getFeedbackEmail() {
		return feedbackEmail;
	}

	public void setFeedbackEmail(String feedbackEmail) {
		this.feedbackEmail = feedbackEmail;
	}
	
}
