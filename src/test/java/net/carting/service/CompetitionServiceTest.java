package net.carting.service;

import static junit.framework.Assert.assertEquals;

import java.util.ArrayList;
import java.util.List;

import net.carting.domain.CarClass;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassCompetitionNumber;
import net.carting.domain.Team;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
public class CompetitionServiceTest {

	@InjectMocks
	private CompetitionServiceImpl competitionService;
	
    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }
	
    @Test
    public void getDifferenceBetweenCarClassesAndCarClassCompetitionsTest() {
    	
    	CarClass carClass1 = new CarClass();
    	carClass1.setName("Популярний");
    	CarClass carClass2 = new CarClass();
    	carClass2.setName("Піонер-Н");
    	CarClass carClass3 = new CarClass();
    	carClass3.setName("Піонер-Б");
    	
    	List<CarClass> carClasses = new ArrayList<CarClass>();
    	carClasses.add(carClass1);
    	carClasses.add(carClass2);
    	carClasses.add(carClass3);
    	
    	CarClassCompetition carClassCompetition1 = new CarClassCompetition();
    	carClassCompetition1.setCarClass(carClass1);
    	CarClassCompetition carClassCompetition2 = new CarClassCompetition();
    	carClassCompetition2.setCarClass(carClass2);
    	
    	List<CarClassCompetition> carClassCompetitions = new ArrayList<CarClassCompetition>();
    	carClassCompetitions.add(carClassCompetition1);
    	carClassCompetitions.add(carClassCompetition2);
    	
    	List<CarClass> expectedResult = new ArrayList<CarClass>();
    	expectedResult.add(carClass3);
    	
    	List<CarClass> result = competitionService.getDifferenceBetweenCarClassesAndCarClassCompetitions(
				carClasses, carClassCompetitions); 
    	
    	assertEquals("Expected 1 results", 1, result.size()); 	
    	assertEquals("Expected Піонер-Б", expectedResult, result);
    	assertEquals("Expected Піонер-Б", expectedResult.get(0).getName(), result.get(0).getName());
    	
    }
    
    @Test
    public void getTeamsFromRacerCarClassCompetitionNumbersTest() {
    	
    	Team team1 = new Team();
    	team1.setName("team1");
    	Team team2 = new Team();
    	team2.setName("team2");
    	Team team3 = new Team();
    	team3.setName("team3");
    	
    	List<Team> teams = new ArrayList<Team>();
    	teams.add(team1);
    	teams.add(team2);
    	teams.add(team3);
    	
    	Racer racer1 = new Racer();
    	racer1.setTeam(team1);
    	RacerCarClassCompetitionNumber racerCarClassCompetitionNumber1 = new RacerCarClassCompetitionNumber();
    	racerCarClassCompetitionNumber1.setRacer(racer1);
    	
    	Racer racer2 = new Racer();
    	racer2.setTeam(team2);
    	RacerCarClassCompetitionNumber racerCarClassCompetitionNumber2 = new RacerCarClassCompetitionNumber();
    	racerCarClassCompetitionNumber2.setRacer(racer2);
    	
    	Racer racer3 = new Racer();
    	racer3.setTeam(team2);
    	RacerCarClassCompetitionNumber racerCarClassCompetitionNumber3 = new RacerCarClassCompetitionNumber();
    	racerCarClassCompetitionNumber3.setRacer(racer3);
    	
    	Racer racer4 = new Racer();
    	racer4.setTeam(team3);
    	RacerCarClassCompetitionNumber racerCarClassCompetitionNumber4 = new RacerCarClassCompetitionNumber();
    	racerCarClassCompetitionNumber4.setRacer(racer4);
    	
    	List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumbers = 
    			new ArrayList<RacerCarClassCompetitionNumber>();
    	racerCarClassCompetitionNumbers.add(racerCarClassCompetitionNumber1);
    	racerCarClassCompetitionNumbers.add(racerCarClassCompetitionNumber2);
    	racerCarClassCompetitionNumbers.add(racerCarClassCompetitionNumber3);
    	racerCarClassCompetitionNumbers.add(racerCarClassCompetitionNumber4);
    	
    	List<Team> expectedResult = teams;
    	List<Team> result = competitionService.getTeamsFromRacerCarClassCompetitionNumbers(racerCarClassCompetitionNumbers);
    	
    	assertEquals("Expected 3 results", 3, result.size()); 	
    	assertEquals("Expected list with 3 elements", expectedResult, result);
    	assertEquals("Expected team1", expectedResult.get(0).getName(), result.get(0).getName());
    	
    }
	
}
