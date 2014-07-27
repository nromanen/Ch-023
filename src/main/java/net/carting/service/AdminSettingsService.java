package net.carting.service;

import net.carting.domain.AdminSettings;

import java.util.List;

public interface AdminSettingsService {

    public AdminSettings getAdminSettings();

    public void updatePerentalPermissionYears(int value);

    public void updatePointsByPlaces(String value);

    public void updateFeedbackEmail(String value);

    public List<String> getPointsByPlacesList();

}
