package net.carting.service;

import static junit.framework.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.times;
import static org.mockito.Matchers.anyString;

import java.util.ArrayList;
import java.util.List;

import net.carting.dao.AdminSettingsDAO;
import net.carting.domain.AdminSettings;
import net.carting.domain.Race;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.beans.factory.annotation.Autowired;

@RunWith(MockitoJUnitRunner.class)
public class AdminSettingsTest {

	@InjectMocks
	private AdminSettingsServiceImpl  adminSettingsService;
	
    @Mock
    private AdminSettingsDAO adminSettingsDAO;
    
    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
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
    
}
