package net.carting.dao;

import java.util.List;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.CarClassCompetitionResult;

public interface CarClassCompetitionResultDAO {
	
	public List<CarClassCompetitionResult> getAllCarClassCompetitionResults();

    public CarClassCompetitionResult getCarClassCompetitionResultById(int id);

    public void addCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult);

    public void updateCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult);

    public void deleteCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult);
    
    public List<CarClassCompetitionResult> getCarClassCompetitionResultsByCarClassCompetition(CarClassCompetition carClassCompetition);
    
    public List<CarClassCompetitionResult> getCarClassCompetitionResultsOrderedByPoints(CarClassCompetition carClassCompetition);
    

}
