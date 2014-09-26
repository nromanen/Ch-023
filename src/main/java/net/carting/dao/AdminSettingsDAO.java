package net.carting.dao;

import net.carting.domain.AdminSettings;

public interface AdminSettingsDAO {

    public AdminSettings getAdminSettings();

    public void updateParentalPermissionYears(int value);

    public void updatePointsByPlaces(String value);

    public void updateFeedbackEmail(String value);

    public boolean uploadDbDump(String sqlQuery);

}
