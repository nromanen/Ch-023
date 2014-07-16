package net.carting.service;

import net.carting.dao.CarClassCompetitionResultDAO;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.CarClassCompetitionResult;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;

import java.util.ArrayList;
import java.util.List;

import static junit.framework.Assert.assertEquals;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class CarClassCompetitionResultServiceTest {
	
	@InjectMocks
    CarClassCompetitionResultServiceImpl  carClassCompetitionResultServiceImpl;

    @Mock
    private CarClassCompetitionResultDAO carClassCompetitionResultDAO;

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
        verify(carClassCompetitionResultDAO,times(1)).addCarClassCompetitionResult(carClassCompetitionResult);    }

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
        when( carClassCompetitionResultDAO.getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition)).thenReturn(carClassCompetitionResults);
        assertEquals("Expected 2 results", 2, (carClassCompetitionResultServiceImpl.getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition).size()));
    }
    
    @Test
    public void testDeleteCarClassCompetitionResult() throws Exception {
    	CarClassCompetitionResult carClassCompetitionResult = new CarClassCompetitionResult();
    	carClassCompetitionResult.setComment("this is a test comment");
    	carClassCompetitionResultServiceImpl.deleteCarClassCompetitionResult(carClassCompetitionResult);
        verify(carClassCompetitionResultDAO,times(1)).deleteCarClassCompetitionResult(carClassCompetitionResult);
    }
    
    @Test
    public void testUpdateCarClassCompetitionResult() throws Exception {
    	CarClassCompetitionResult carClassCompetitionResult = new CarClassCompetitionResult();
    	carClassCompetitionResult.setComment("this is a test comment");
        carClassCompetitionResultServiceImpl.updateCarClassCompetitionResult(carClassCompetitionResult);
        verify(carClassCompetitionResultDAO,times(1)).updateCarClassCompetitionResult(carClassCompetitionResult);
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
        when( carClassCompetitionResultDAO.getCarClassCompetitionResultsOrderedByPoints(carClassCompetition)).thenReturn(carClassCompetitionResults);
        assertEquals("Expected 2 results", 2, (carClassCompetitionResultServiceImpl.getCarClassCompetitionResultsOrderedByPoints(carClassCompetition).size()));
    } 

}
