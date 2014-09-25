package net.carting.service;

import static junit.framework.Assert.assertEquals;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.List;

import net.carting.dao.AdminSettingsDAO;
import net.carting.domain.AdminSettings;
import net.carting.service.Util.TestDatabaseUtil;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
public class AdminSettingsTest {

    @InjectMocks
    private AdminSettingsServiceImpl adminSettingsService;

    @Mock
    private AdminSettingsDAO adminSettingsDAO;
    
    private TestDatabaseUtil testDatabaseUtil;

    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
        
        testDatabaseUtil = new TestDatabaseUtil();
        testDatabaseUtil.dropTestTables();
        testDatabaseUtil.createTestTables();
    }

    @Test
    public void testGetPointsByPlacesList() {

        AdminSettings adminSettings = new AdminSettings();
        adminSettings.setPointsByPlaces("1,2,3");

        List<String> expectedResult = new ArrayList<String>();
        expectedResult.add("1");
        expectedResult.add("2");
        expectedResult.add("3");

        when(adminSettingsDAO.getAdminSettings()).thenReturn(adminSettings);

        List<String> result = adminSettingsService.getPointsByPlacesList();

        assertEquals("Expected true", expectedResult, result);
        assertEquals("Expected 3 objects", 3, result.size());
    }
    
    @Test
    public void testGetPointFromTableB() {
    	int result = AdminSettings.getPointFromTableB(1, 1);
    	int expectedResult = 10;
    	assertEquals("Expected true", expectedResult, result);
    	result = AdminSettings.getPointFromTableB(2, 2);
    	expectedResult = 1;
    	assertEquals("Expected true", expectedResult, result);
    	result = AdminSettings.getPointFromTableB(1, 2);
    	expectedResult = 20;
    	assertEquals("Expected true", expectedResult, result);
    }
    
    @Test
    public void testUpdatePerentalPermissionYears() throws Exception {
        AdminSettings expectedResult = new AdminSettings();
        int parentalPermissionYears = 20;
        expectedResult.setParentalPermissionYears(parentalPermissionYears);
        adminSettingsService.updatePerentalPermissionYears(parentalPermissionYears);
        when(adminSettingsService.getAdminSettings()).thenReturn(expectedResult);
        assertEquals(parentalPermissionYears, expectedResult.getParentalPermissionYears());
    }

    @Test
    public void testUpdatePointsByPlaces() throws Exception {
        AdminSettings expectedResult = new AdminSettings();
        String pointsByPlaces = "20, 10, 5";
        expectedResult.setPointsByPlaces(pointsByPlaces);;
        adminSettingsService.updatePointsByPlaces(pointsByPlaces);
        when(adminSettingsService.getAdminSettings()).thenReturn(expectedResult);
        assertEquals(pointsByPlaces, expectedResult.getPointsByPlaces());
    }
    
    @Test
    public void testUpdateFeedbackEmail() throws Exception {
        AdminSettings expectedResult = new AdminSettings();
        String feedbackEmail = "test@test.com";
        expectedResult.setFeedbackEmail(feedbackEmail);;
        adminSettingsService.updateFeedbackEmail(feedbackEmail);
        when(adminSettingsService.getAdminSettings()).thenReturn(expectedResult);
        assertEquals(feedbackEmail, expectedResult.getFeedbackEmail());
    }
}
