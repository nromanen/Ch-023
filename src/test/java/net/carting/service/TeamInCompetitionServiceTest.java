package net.carting.service;

import static junit.framework.Assert.assertEquals;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.carting.dao.AdminSettingsDAO;
import net.carting.dao.RacerCarClassCompetitionNumberDAO;
import net.carting.domain.AdminSettings;
import net.carting.domain.CarClass;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Competition;
import net.carting.domain.Document;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassCompetitionNumber;
import net.carting.domain.Team;
import net.carting.domain.TeamInCompetition;
import net.carting.util.DateUtil;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
public class TeamInCompetitionServiceTest {

	@InjectMocks
	private TeamInCompetitionServiceImpl teamInCompetitionService;
	
    @Mock
    private RacerCarClassCompetitionNumberDAO racerCarClassCompetitionNumberDAO;
    
    @Mock
    private AdminSettingsDAO adminSettingsDAO;   
    
    
    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }
    
    @Test
    public void isValidTeamInCompetitionMapTest() {
    	
    	Competition competition = new Competition();
    	competition.setId(1);
    	competition.setDateEnd(DateUtil.getDateFromString("2014-06-14"));
    	
    	CarClass carClass = new CarClass();
    	carClass.setName("Популярний");
    	
    	CarClassCompetition carClassCompetition = new CarClassCompetition();
    	carClassCompetition.setCarClass(carClass);
    	carClassCompetition.setCompetition(competition);
    	Set<CarClassCompetition> carClassCompetitions = new HashSet<CarClassCompetition>();
    	carClassCompetitions.add(carClassCompetition);
    	
    	competition.setCarClassCompetitions(carClassCompetitions);
    	
    	//-----------------team 1----------------------- valid
    	Team team1 = new Team();
    	team1.setId(1);
    	team1.setName("team1");
    	
    	TeamInCompetition teamInCompetition1 = new TeamInCompetition();
    	teamInCompetition1.setTeam(team1);
    	teamInCompetition1.setCompetition(competition);
    	//-----------------------------------------------------------
    	
    	List<TeamInCompetition> teamInCompetitions = new ArrayList<TeamInCompetition>();
    	teamInCompetitions.add(teamInCompetition1);
    	
    	//-----------------------racer 1------------------- valid
    	Racer racer1 = new Racer();
    	racer1.setBirthday(DateUtil.getDateFromString("2000-03-04"));
    	racer1.setTeam(team1);
    	
    	Document document11 = new Document(); 
    	document11.setType(Document.TYPE_RACER_LICENCE);
    	document11.setFinishDate(DateUtil.getDateFromString("2016-07-24"));
    	document11.setApproved(true);
    	
    	Document document12 = new Document(); 
    	document12.setType(Document.TYPE_RACER_INSURANCE);
    	document12.setFinishDate(DateUtil.getDateFromString("2015-07-24"));
    	document12.setApproved(true);
    	
    	Document document13 = new Document(); 
    	document13.setType(Document.TYPE_RACER_MEDICAL_CERTIFICATE);
    	document13.setFinishDate(DateUtil.getDateFromString("2015-07-24"));
    	document13.setApproved(true);
    	
    	Document document14 = new Document(); 
    	document14.setType(Document.TYPE_RACER_PERENTAL_PERMISSIONS);
    	document14.setFinishDate(DateUtil.getDateFromString("2015-07-24"));
    	document14.setApproved(true);
    	
    	Set<Document> documents = new HashSet<Document>();
    	documents.add(document11);
    	documents.add(document12);
    	documents.add(document13);
    	documents.add(document14);
    	racer1.setDocuments(documents);
    	
    	Set<Racer> racers = new HashSet<Racer>();
    	racers.add(racer1);
    	team1.setRacers(racers);  	
    	//--------------------------------------------------
    	
    	//------------------register racer for competition-------
    	List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumbers = 
    			new ArrayList<RacerCarClassCompetitionNumber>();
    	
    	RacerCarClassCompetitionNumber racerCarClassCompetitionNumber = new RacerCarClassCompetitionNumber();
    	racerCarClassCompetitionNumber.setCarClassCompetition(carClassCompetition);
    	racerCarClassCompetitionNumber.setRacer(racer1);
    	
    	racerCarClassCompetitionNumbers.add(racerCarClassCompetitionNumber);
    	//----------------------------------------------------
    	
    	Map<TeamInCompetition, Boolean> expectedResult = new HashMap<TeamInCompetition, Boolean>();
    	expectedResult.put(teamInCompetition1, true);
    	 
    	AdminSettings adminSettings = new AdminSettings();
    	adminSettings.setParentalPermissionYears(18);
    	when(adminSettingsDAO.getAdminSettings()).thenReturn(adminSettings);
    	when(racerCarClassCompetitionNumberDAO.getRacerCarClassCompetitionNumbersByCompetitionIdAndTeamId(
    			teamInCompetition1.getCompetition().getId(), teamInCompetition1.getTeam().getId()))
    			.thenReturn(racerCarClassCompetitionNumbers);
    	
    	Map<TeamInCompetition, Boolean> result = teamInCompetitionService.isValidTeamInCompetitionMap(teamInCompetitions);
    	
    	assertEquals("Expected true", expectedResult, result);
    	assertEquals("Expected 1 item", expectedResult.size(), result.size());
    	
    }
    
}
