package net.carting.service;

import java.util.List;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.Racer;
import net.carting.domain.Team;

public interface CarClassCompetitionService {
	
	public List<CarClassCompetition> getAllCarClassCompetitions();

    public CarClassCompetition getCarClassCompetitionById(int id);

    public void addCarClassCompetition(CarClassCompetition carClassCompetition);

    public void updateCarClassCompetition(CarClassCompetition carClassCompetition);

    public void deleteCarClassCompetition(CarClassCompetition carClassCompetition);
    
    public List<CarClassCompetition> getCarClassCompetitionsByCompetitionId(int competitonId);
    
    public List<CarClassCompetition> getCarClassCompetitionsByCarClassId(int carClassId);
    
	/**
	 * This method gets list of team racers who are NOT valid to registration.
	 * 
	 * @param carClassCompetitionId 
	 * Car class competition id in which we want to get NOT valid racers of team
	 * @param team in which we want to get NOT valid racers
	 * @return List of team racers who are NOT valid to registration
	 * @author Ivan Kozub
	 * 
	 */    
    public List<Racer> getNotValidRacersToRegistration(int carClassCompetitionId, Team team);

}
