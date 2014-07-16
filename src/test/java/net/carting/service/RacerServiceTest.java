package net.carting.service;

import static junit.framework.Assert.assertEquals;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import net.carting.dao.AdminSettingsDAO;
import net.carting.dao.CarClassDAO;
import net.carting.dao.RacerDAO;
import net.carting.domain.AdminSettings;
import net.carting.domain.CarClass;
import net.carting.domain.Document;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassNumber;
import net.carting.domain.Team;
import net.carting.util.DateUtil;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
public class RacerServiceTest {

	@InjectMocks
	private RacerServiceImpl racerService;
	
    @Mock
    private CarClassDAO carClassDAO;
    
    @Mock
    private AdminSettingsDAO adminSettingsDAO;
    
    @Mock
    private RacerDAO racerDAO;
 
    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }
    
    @Test
    public void parseCarClassesTest() {
    	
    	CarClass carClass = new CarClass();
    	carClass.setId(1);
    	carClass.setName("Популярний");
    	
    	String carClassesId = "1,1,1,1";
		String carClassNumbers = "1,2,3,4"; 
		
		Racer racer = new Racer();
		
		//----creating expected result-------------------
		RacerCarClassNumber racerCarClassNumber1 = new RacerCarClassNumber();
		racerCarClassNumber1.setCarClass(carClass);
		racerCarClassNumber1.setRacer(racer);
		racerCarClassNumber1.setNumber(1);
		
		RacerCarClassNumber racerCarClassNumber2 = new RacerCarClassNumber();
		racerCarClassNumber2.setCarClass(carClass);
		racerCarClassNumber2.setRacer(racer);
		racerCarClassNumber2.setNumber(2);
		
		RacerCarClassNumber racerCarClassNumber3 = new RacerCarClassNumber();
		racerCarClassNumber3.setCarClass(carClass);
		racerCarClassNumber3.setRacer(racer);
		racerCarClassNumber3.setNumber(3);
		
		RacerCarClassNumber racerCarClassNumber4 = new RacerCarClassNumber();
		racerCarClassNumber4.setCarClass(carClass);
		racerCarClassNumber4.setRacer(racer);
		racerCarClassNumber4.setNumber(4);

		Set<RacerCarClassNumber> racerCarClassNumbers = new HashSet<RacerCarClassNumber>();
		racerCarClassNumbers.add(racerCarClassNumber1);
		racerCarClassNumbers.add(racerCarClassNumber2);
		racerCarClassNumbers.add(racerCarClassNumber3);
		racerCarClassNumbers.add(racerCarClassNumber4);
		//----------------------------------------
		
    	when(carClassDAO.getCarClassById(carClass.getId())).thenReturn(carClass);
    	
    	Set<RacerCarClassNumber> result = racerService.parseCarClasses(carClassesId, carClassNumbers, racer);
    	
    	assertEquals("Expected true", racerCarClassNumbers, result);
    	assertEquals("Expected 4", 4, result.size());
    	
    }
    
    @Test
    public void parseUpdatedRacerCarClassNumbers() {
    	Racer racer =new Racer();
    	CarClass carClassPopular = new CarClass();
    	carClassPopular.setId(1);
    	carClassPopular.setName("Популярний");
    	
    	CarClass carClassCadet = new CarClass();
    	carClassCadet.setId(2);
    	carClassCadet.setName("Кадет");
    	
		Set<RacerCarClassNumber> racerCarClassNumbers = new HashSet<RacerCarClassNumber>();
    	
    	RacerCarClassNumber racerCarClassNumber1 = new RacerCarClassNumber();
    	racerCarClassNumber1.setId(1);
    	racerCarClassNumber1.setCarClass(carClassPopular);    	
    	racerCarClassNumber1.setRacer(racer);
    	racerCarClassNumber1.setNumber(1);
    	racerCarClassNumbers.add(racerCarClassNumber1);
    	
    	RacerCarClassNumber racerCarClassNumber2 = new RacerCarClassNumber();
    	racerCarClassNumber2.setId(2);
    	racerCarClassNumber2.setCarClass(carClassCadet);    	
    	racerCarClassNumber2.setRacer(racer);
    	racerCarClassNumber2.setNumber(1);    	
    	racerCarClassNumbers.add(racerCarClassNumber2);
    	
    	when(carClassDAO.getCarClassById(1)).thenReturn(carClassPopular);
    	when(carClassDAO.getCarClassById(2)).thenReturn(carClassCadet);
    	String updatedRacerCarClassNumbersStr = "1,1,1#2,2,1";
		assertEquals("Expected Set<RacerCarClassNumber>", racerCarClassNumbers,
				racerService.parseUpdatedRacerCarClassNumbers(
						updatedRacerCarClassNumbersStr, racer));
    	
    }
    
    @Test
    public void TestGetSetOfRacersNeedingPerentalPermisionByTeam() {
    	
    	Set<Racer> racers = new HashSet<Racer>();
    	
    	Document documentRacer1 = new Document();
    	documentRacer1.setType(Document.TYPE_RACER_PERENTAL_PERMISSIONS);
    	Set<Document> documentsRacer1 = new HashSet<Document>();
    	documentsRacer1.add(documentRacer1);
    	Racer racer1 = new Racer();
    	racer1.setDocuments(documentsRacer1);
    	racers.add(racer1);
    	
    	List<Racer> racersWithSetPerentalPermission = new ArrayList<Racer>();
    	racersWithSetPerentalPermission.add(racer1);
    	
    	Document documentRacer2 = new Document();
    	documentRacer2.setType(Document.TYPE_RACER_LICENCE);
    	Set<Document> documentsRacer2 = new HashSet<Document>();
    	documentsRacer1.add(documentRacer2);
    	Racer racer2 = new Racer();
    	racer2.setDocuments(documentsRacer2);
    	racer2.setBirthday(DateUtil.getDateFromString("2014-09-09"));
    	racers.add(racer2);
    	
    	Document documentRacer3 = new Document();
    	documentRacer3.setType(Document.TYPE_RACER_LICENCE);
    	Set<Document> documentsRacer3 = new HashSet<Document>();
    	documentsRacer3.add(documentRacer3);
    	Racer racer3 = new Racer();
    	racer3.setDocuments(documentsRacer3);
    	racer3.setBirthday(DateUtil.getDateFromString("1980-09-09"));
    	racers.add(racer3);    	
    	
    	Team team = new Team();
    	team.setRacers(racers);
    	AdminSettings adminSettings = new AdminSettings();
    	adminSettings.setParentalPermissionYears(18);
    	when(adminSettingsDAO.getAdminSettings()).thenReturn(adminSettings);
    	when(racerDAO.getListOfRacersWithSetDocumentByDocumentType(Document.TYPE_RACER_PERENTAL_PERMISSIONS)).thenReturn(racersWithSetPerentalPermission);
    	
    	assertEquals("Expected 1", 1,
				racerService.getSetOfRacersNeedingPerentalPermisionByTeam(team).size());    	
    }
}
