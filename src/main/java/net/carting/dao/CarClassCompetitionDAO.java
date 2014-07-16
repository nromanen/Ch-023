package net.carting.dao;

import java.util.List;

import net.carting.domain.CarClassCompetition;

public interface CarClassCompetitionDAO {
	
	public List<CarClassCompetition> getAllCarClassCompetitions();

    public CarClassCompetition getCarClassCompetitionById(int id);

    public void addCarClassCompetition(CarClassCompetition carClassCompetition);

    public void updateCarClassCompetition(CarClassCompetition carClassCompetition);

    public void deleteCarClassCompetition(CarClassCompetition carClassCompetition);

    public List<CarClassCompetition> getCarClassCompetitionsByCompetitionId(int competitonId);
    
}
