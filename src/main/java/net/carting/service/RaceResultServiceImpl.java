package net.carting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.carting.dao.RaceResultDAO;
import net.carting.domain.Race;
import net.carting.domain.RaceResult;
import net.carting.domain.Racer;

@Service
public class RaceResultServiceImpl implements RaceResultService {
	
	@Autowired
	private RaceResultDAO raceResultDAO;

	/**
	 * This method  returns all race results
	 * 
	 * This method returns all race results by all competitions.
	 * 
	 * @return List  of car class competition result objects.
	 * 
	 * @author Volodmyr Slobodian
	 * 
	 */
	@Override
	@Transactional
	public List<RaceResult> getAllRaceResults() {
		return raceResultDAO.getAllRaceResults();
	}


	/**
	 * This method  gets the race result by  race result id.
	 * 
	 * This method  gets the race result by race result id given as parameter.
	 * 
	 * @param id 
	 * Id of Race result by which we want to get the object.
	 * 
	 * @return Object of race result.
	 * 
	 * @author Volodmyr Slobodian
	 * 
	 */
	@Override
	@Transactional
	public RaceResult getRaceResultById(int id) {	
		return raceResultDAO.getRaceResultById(id);
	}

	/**
	 * This method  adds the race result.
	 * 
	 * This method adds the race result given as a parameter.
	 * 
	 * @param raceResult 
	 * Object of raceResult which we want to add
	 * 
	 * @author Volodmyr Slobodian
	 * 
	 */
	@Override
	@Transactional
	public void addRaceResult(RaceResult raceResult) {
		raceResultDAO.addRaceResult(raceResult);
	}

	/**
	 * This method  updates the race result.
	 * 
	 * This method updates the race result given as a parameter.
	 * 
	 * @param raceResult 
	 * Object of raceResult which we want to update
	 * 
	 * @author Volodmyr Slobodian
	 * 
	 */
	@Override
	@Transactional
	public void updateRaceResult(RaceResult raceResult) {
		raceResultDAO.updateRaceResult(raceResult);
	}

	/**
	 * This method  deletes the race result.
	 * 
	 * This method deletes the race result given as a parameter.
	 * 
	 * @param raceResult 
	 * Object of raceResult which we want to delete
	 * 
	 * @author Volodmyr Slobodian
	 * 
	 */
	@Override
	@Transactional
	public void deleteRaceResult(RaceResult raceResult) {
		raceResultDAO.deleteRaceResult(raceResult);
	}

	/**
	 * This method gets list of results by specified race.
	 * 
	 * This method gets list of results by specified race as a parameter.
	 * 
	 * @param race 
	 * Object that defines by what race we want to get results
	 * 
	 * @return List of race result objects
	 * 
	 * @author Volodmyr Slobodian
	 * 
	 */	
	@Override
	@Transactional
	public List<RaceResult> getRaceResultsByRace(Race race) {
		return raceResultDAO.getRaceResultsByRace(race);
	}

}
