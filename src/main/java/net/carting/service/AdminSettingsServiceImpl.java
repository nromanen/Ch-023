package net.carting.service;

import java.util.Arrays;
import java.util.List;

import net.carting.dao.AdminSettingsDAO;
import net.carting.domain.AdminSettings;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AdminSettingsServiceImpl implements AdminSettingsService {

	@Autowired
	private AdminSettingsDAO adminSettingsDAO;
	
	@Override
	@Transactional
	public AdminSettings getAdminSettings() {
		return adminSettingsDAO.getAdminSettings();
	}

	@Override
	@Transactional
	public void updatePerentalPermissionYears(int value) {
		adminSettingsDAO.updatePerentalPermissionYears(value);
	}

	@Override
	@Transactional
	public void updatePointsByPlaces(String value) {
		adminSettingsDAO.updatePointsByPlaces(value);
	}
	
	@Override
	@Transactional
	public void updateFeedbackEmail(String value){
		adminSettingsDAO.updateFeedbackEmail(value);
	}

	@Override
	@Transactional
	public List<String> getPointsByPlacesList() {
		String pointsByPlacesStr = adminSettingsDAO.getAdminSettings().getPointsByPlaces();
		List<String> pointsByPlacesList = Arrays.asList(pointsByPlacesStr.split(","));		
		return pointsByPlacesList;
	}
}
