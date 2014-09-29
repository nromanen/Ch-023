package net.carting.service;

import static junit.framework.Assert.assertEquals;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.List;

import net.carting.dao.CarClassCompetitionResultDAO;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.CarClassCompetitionResult;
import net.carting.domain.Competition;
import net.carting.domain.Race;
import net.carting.domain.RaceResult;
import net.carting.domain.RacerCarClassCompetitionNumber;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
public class CarClassCompetitionResultServiceTest {

    @InjectMocks
    CarClassCompetitionResultServiceImpl carClassCompetitionResultServiceImpl;

    @Mock
    private CarClassCompetitionResultDAO carClassCompetitionResultDAO;
    
    @Mock
    private RacerCarClassCompetitionNumberService racerCarClassCompetitionNumberService;
    
    @Mock
    private CompetitionService competitionService;
    
    @Mock
    private RaceResultService raceResultService;
    
    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }


    @Test
    public void testGetAllCarClassCompetitionResults() {
        List<CarClassCompetitionResult> CarClassCompetitionResultList = new ArrayList<CarClassCompetitionResult>();
        CarClassCompetitionResultList.add(new CarClassCompetitionResult());
        CarClassCompetitionResultList.add(new CarClassCompetitionResult());
        when(carClassCompetitionResultDAO.getAllCarClassCompetitionResults()).thenReturn(CarClassCompetitionResultList);
        assertEquals("Expected 2 results", 2, carClassCompetitionResultServiceImpl.getAllCarClassCompetitionResults().size());
    }


    @Test
    public void testAddCarClassCompetitionResult() throws Exception {
        CarClassCompetitionResult carClassCompetitionResult = new CarClassCompetitionResult();
        carClassCompetitionResult.setComment("this is a test comment");
        carClassCompetitionResultServiceImpl.addCarClassCompetitionResult(carClassCompetitionResult);
        verify(carClassCompetitionResultDAO, times(1)).addCarClassCompetitionResult(carClassCompetitionResult);
    }

    @Test
    public void testGetCarClassCompetitionResultsByCarClassCompetition() throws Exception {
        List<CarClassCompetitionResult> carClassCompetitionResults = new ArrayList<CarClassCompetitionResult>();
        CarClassCompetitionResult result1 = new CarClassCompetitionResult();
        CarClassCompetitionResult result2 = new CarClassCompetitionResult();
        CarClassCompetition carClassCompetition = new CarClassCompetition();
        carClassCompetition.setCircleCount(5);
        result1.setComment("test1 result");
        result1.setComment("test2 result");
        carClassCompetitionResults.add(result1);
        carClassCompetitionResults.add(result2);
        when(carClassCompetitionResultDAO.getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition)).thenReturn(carClassCompetitionResults);
        assertEquals("Expected 2 results", 2, (carClassCompetitionResultServiceImpl.getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition).size()));
    }

    @Test
    public void testDeleteCarClassCompetitionResult() throws Exception {
        CarClassCompetitionResult carClassCompetitionResult = new CarClassCompetitionResult();
        carClassCompetitionResult.setComment("this is a test comment");
        carClassCompetitionResultServiceImpl.deleteCarClassCompetitionResult(carClassCompetitionResult);
        verify(carClassCompetitionResultDAO, times(1)).deleteCarClassCompetitionResult(carClassCompetitionResult);
    }

    @Test
    public void testUpdateCarClassCompetitionResult() throws Exception {
        CarClassCompetitionResult carClassCompetitionResult = new CarClassCompetitionResult();
        carClassCompetitionResult.setComment("this is a test comment");
        carClassCompetitionResultServiceImpl.updateCarClassCompetitionResult(carClassCompetitionResult);
        verify(carClassCompetitionResultDAO, times(1)).updateCarClassCompetitionResult(carClassCompetitionResult);
    }

    @Test
    public void testGetCarClassCompetitionResultsOrderedByPoints() throws Exception {
        List<CarClassCompetitionResult> carClassCompetitionResults = new ArrayList<CarClassCompetitionResult>();
        CarClassCompetitionResult result1 = new CarClassCompetitionResult();
        CarClassCompetitionResult result2 = new CarClassCompetitionResult();
        CarClassCompetition carClassCompetition = new CarClassCompetition();
        carClassCompetition.setCircleCount(5);
        result1.setComment("test1 result");
        result1.setComment("test2 result");
        carClassCompetitionResults.add(result1);
        carClassCompetitionResults.add(result2);
        when(carClassCompetitionResultDAO.getCarClassCompetitionResultsOrderedByPoints(carClassCompetition)).thenReturn(carClassCompetitionResults);
        assertEquals("Expected 2 results", 2, (carClassCompetitionResultServiceImpl.getCarClassCompetitionResultsOrderedByPoints(carClassCompetition).size()));
    }
    
    @Test
    public void setAbsoluteResultsTest() {
        Race race = new Race();
        race.setRaceNumber(1);
        CarClassCompetition carClassCompetition = new CarClassCompetition();
        carClassCompetition.setId(112);
        Competition competition = new Competition();
        competition.setEnabled(false);
        carClassCompetition.setCompetition(competition);
        RacerCarClassCompetitionNumber racerCarClassCompetitionNumber = new RacerCarClassCompetitionNumber();
        racerCarClassCompetitionNumber.setNumberInCompetition(12);
        CarClassCompetitionResult carClassCompetitionResult = new CarClassCompetitionResult();
        carClassCompetitionResult.setAbsolutePlace(0);
        carClassCompetitionResult.setAbsolutePoints(0);
        carClassCompetitionResult.setRace2points(0);
        carClassCompetitionResult.setRacerCarClassCompetitionNumber(racerCarClassCompetitionNumber);
        List<RaceResult> raceResults = new ArrayList<RaceResult>();
        RaceResult raceResult = new RaceResult();
        raceResult.setCarNumber(12);
        raceResult.setPlace(1);
        raceResult.setPoints(100);
        raceResults.add(raceResult);
        
        List<RacerCarClassCompetitionNumber> carClassCompetitionNumbers = new ArrayList<RacerCarClassCompetitionNumber>();
        carClassCompetitionNumbers.add(racerCarClassCompetitionNumber);
        
        for (RaceResult raceRes : raceResults) {
            if (raceRes.getCarNumber() == racerCarClassCompetitionNumber
                    .getNumberInCompetition()) {
                carClassCompetitionResult.setAbsolutePlace(raceRes
                        .getPlace());
                carClassCompetitionResult.setAbsolutePoints(raceRes
                        .getPoints());
            }
        }
        List<CarClassCompetitionResult> carClassCompetitionResultsList = new ArrayList<CarClassCompetitionResult>();
        carClassCompetitionResultsList.add(carClassCompetitionResult);
        
        when(carClassCompetitionResultDAO.getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition)).thenReturn(carClassCompetitionResultsList);
        when(racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersByCarClassCompetitionId(carClassCompetition.getId())).thenReturn(carClassCompetitionNumbers);
        doNothing().when(competitionService).updateCompetition(competition);
        doNothing().when(carClassCompetitionResultDAO).updateCarClassCompetitionResult(carClassCompetitionResult);
        when(raceResultService.getRaceResultsByRace(race)).thenReturn(raceResults);
        
        carClassCompetitionResultServiceImpl.setAbsoluteResults(carClassCompetition, race);
        
        verify(carClassCompetitionResultDAO, times(1)).updateCarClassCompetitionResult(carClassCompetitionResult);
        verify(competitionService, times(1)).updateCompetition(competition);
        verify(racerCarClassCompetitionNumberService, times(1)).getRacerCarClassCompetitionNumbersByCarClassCompetitionId(carClassCompetition.getId());
        verify(raceResultService, times(1)).getRaceResultsByRace(race);
        verify(carClassCompetitionResultDAO, times(1)).getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition);
        verifyNoMoreInteractions(racerCarClassCompetitionNumberService, competitionService, carClassCompetitionResultDAO, raceResultService);
        
        
    }
    
    @Test
    public void setAbsoluteResultsTest2() {
        Race race = new Race();
        race.setRaceNumber(2);
        CarClassCompetition carClassCompetition = new CarClassCompetition();
        carClassCompetition.setId(112);
        List<CarClassCompetitionResult> absoluteResultsList = new ArrayList<CarClassCompetitionResult>();
        List<RaceResult> raceResults = new ArrayList<RaceResult>();
        
        Competition competition = new Competition();
        competition.setEnabled(false);
        carClassCompetition.setCompetition(competition);
        RacerCarClassCompetitionNumber racerCarClassCompetitionNumber = new RacerCarClassCompetitionNumber();
        racerCarClassCompetitionNumber.setNumberInCompetition(12);
        CarClassCompetitionResult carClassCompetitionResult = new CarClassCompetitionResult();
        carClassCompetitionResult.setAbsolutePlace(0);
        carClassCompetitionResult.setAbsolutePoints(0);
        carClassCompetitionResult.setRace2points(0);
        carClassCompetitionResult.setRacerCarClassCompetitionNumber(racerCarClassCompetitionNumber);
        
        RaceResult raceResult = new RaceResult();
        raceResult.setCarNumber(12);
        raceResult.setPlace(1);
        raceResult.setPoints(100);
        raceResults.add(raceResult);
        absoluteResultsList.add(carClassCompetitionResult);
        
        when(raceResultService.getRaceResultsByRace(race)).thenReturn(raceResults);
        doNothing().when(carClassCompetitionResultDAO).updateCarClassCompetitionResult(carClassCompetitionResult);
        
        
        carClassCompetitionResultServiceImpl.setAbsoluteResults(carClassCompetition, race);
        verify(raceResultService, times(1)).getRaceResultsByRace(race);
        verifyNoMoreInteractions(raceResultService);
        
        
    }

}
