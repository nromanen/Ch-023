package net.carting.service;

import net.carting.domain.Race;
import net.carting.domain.RaceResult;
import net.carting.domain.Racer;

import java.util.List;

public interface RaceResultService {

    /**
     * This method  returns all race results
     * <p/>
     * This method returns all race results by all competitions.
     *
     * @return List  of car class competition result objects.
     * @author Volodmyr Slobodian
     */
    public List<RaceResult> getAllRaceResults();

    /**
     * This method  gets the race result by  race result id.
     * <p/>
     * This method  gets the race result by race result id given as parameter.
     *
     * @param id Id of Race result by which we want to get the object.
     * @return Object of race result.
     * @author Volodmyr Slobodian
     */
    public RaceResult getRaceResultById(int id);

    /**
     * This method  adds the race result.
     * <p/>
     * This method adds the race result given as a parameter.
     *
     * @param raceResult Object of raceResult which we want to add
     * @author Volodmyr Slobodian
     */
    public void addRaceResult(RaceResult raceResult);

    /**
     * This method  updates the race result.
     * <p/>
     * This method updates the race result given as a parameter.
     *
     * @param raceResult Object of raceResult which we want to update
     * @author Volodmyr Slobodian
     */
    public void updateRaceResult(RaceResult raceResult);

    /**
     * This method  deletes the race result.
     * <p/>
     * This method deletes the race result given as a parameter.
     *
     * @param raceResult Object of raceResult which we want to delete
     * @author Volodmyr Slobodian
     */
    public void deleteRaceResult(RaceResult raceResult);

    /**
     * This method gets list of results by specified race.
     * <p/>
     * This method gets list of results by specified race as a parameter.
     *
     * @param race Object that defines by what race we want to get results
     * @return List of race result objects
     * @author Volodmyr Slobodian
     */
    public List<RaceResult> getRaceResultsByRace(Race race);
    
    public RaceResult getRaceResultsByRaceAndRacer(Race race, Racer racer);

}
