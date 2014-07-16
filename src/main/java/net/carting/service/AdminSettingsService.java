package net.carting.service;

import java.util.List;

import net.carting.domain.AdminSettings;

public interface AdminSettingsService {

	public AdminSettings getAdminSettings();
	
	public void updatePerentalPermissionYears(int value);
	
	public void updatePointsByPlaces(String value);
	
	public void updateFeedbackEmail(String value);
	
	public List<String> getPointsByPlacesList(); 
	
}
