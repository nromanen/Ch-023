package net.carting.service;

import net.carting.domain.CarClass;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Race;
import net.carting.domain.RaceResult;

import java.util.List;
import java.util.Set;

public interface RaceService {

    /**
     * This method  returns all races
     * <p/>
     * This method returns all races by all competitions.
     *
     * @return List  of race objects.
     * @author Volodmyr Slobodian
     */
    public List<Race> getAllRaces();

    /**
     * This method  gets the race by  race id.
     * <p/>
     * This method  gets the race  by race id given as parameter.
     *
     * @param id Id of race by which we want to get the object.
     * @return Object of race.
     * @author Volodmyr Slobodian
     */
    public Race getRaceById(int id);

    /**
     * This method  adds the race.
     * <p/>
     * This method adds the race given as a parameter.
     *
     * @param race Object of race which we want to add
     * @author Volodmyr Slobodian
     */
    public void addRace(Race race);

    /**
     * This method  updates the race.
     * <p/>
     * This method updates the race given as a parameter.
     *
     * @param race Object of race which we want to update.
     * @author Volodmyr Slobodian
     */
    public void updateRace(Race race);

    /**
     * This method deletes the race.
     * <p/>
     * This method deletes the race given as a parameter.
     *
     * @param race Object of race which we want to update.
     * @author Volodmyr Slobodian
     */
    public void deleteRace(Race race);

    /**
     * This method calculates the chess roll.
     * <p/>
     * This method calculates the chess roll by result sequence of car numbers which specified race contains.
     * Result sequence splits to array of String and then parses to int values.
     *
     * @param race Object that defines by what race we want to calculate the chess roll.
     * @return ArrayList of Integer sets. Each set is a result sequence on each lap. ArrayList size equals number of laps in this race.
     * @author Volodmyr Slobodian
     */
    public List<Set<Integer>> getChessRoll(Race race);

    /**
     * This method calculates race results and write them into database.
     * <p/>
     * This method calculates race results and write them into database.
     * First, we get maps where key is the car number and values are full laps, points and places.
     * Then we get the list of race results, and if the list is empty we add fill the race result object and write it to database
     * If the list is not empty it means that we are updating race results by edited race.
     *
     * @param chessRoll Chess roll that calculates in({@link #getChessRoll(Race)}) method.
     * @param race      Object that defines by what race we want to calculate results.
     * @author Volodmyr Slobodian
     */
    public void setResultTable(List<Set<Integer>> circles, Race race);

    /**
     * This method gets list of results by specified race.
     * <p/>
     * This method gets list of results by specified race as a parameter.
     *
     * @param race Object that defines by what race we want to get results
     * @return List of race result objects
     * @author Volodmyr Slobodian
     */
    public List<RaceResult> getResultTable(Race race);

    /**
     * This method gets list of all racers numbers that are registered in this car class.
     * <p/>
     * This method gets list of all racers numbers that are registered in this car class.
     *
     * @param carClass Object that defines by what car class we want to get the numbers.
     * @return List of racer car numbers that are registered in this car class.
     * @author Volodmyr Slobodian
     */
    public List<Integer> getNumbersArrayByCarClass(CarClass carClass);

    /**
     * This method gets list of all racers numbers that are registered in this car class competition.
     * <p/>
     * This method gets list of all racers numbers that are registered in this car class competition by id of that car class competition.
     *
     * @param carClassCompetitionId Id  of carClassCompetition defines by what car class competition  we want to get the numbers.
     * @return List of racer car numbers that are registered in this car class competition.
     * @author Volodmyr Slobodian
     */
    public List<Integer> getNumbersArrayByCarClassCompetitionId(Integer carClassCompetitionId);

    /**
     * This method gets list of all races  in this car class competition.
     * <p/>
     * This method gets list of all races numbers  in this car class competition.
     *
     * @param carClassCompetition Object defines by what car class competition  we want to get the races.
     * @return List of races  in this car class competition.
     * @author Volodmyr Slobodian
     */
    public List<Race> getRacesByCarClassCompetition(CarClassCompetition carClassCompetition);

    /**
     * This method gets list of all race results  in this car class competition.
     * <p/>
     * This method gets list of all race results  in this car class competition.
     * This method returns the list of race results lists.
     * The size of this list equals quantity of races that were finished.
     *
     * @param carClassCompetition Object defines by what car class competition  we want to get the race results.
     * @return List of race results list  in this car class competition.
     * @author Volodmyr Slobodian
     */
    public List<List<RaceResult>> getRaceResultsByCarClassCompetition(CarClassCompetition carClassCompetition);

    /**
     * This method gets list of chess rolls  in this car class competition.
     * <p/>
     * This method gets list of chess rolls  in this car class competition.
     * In this method we get the list of the races that are already finished
     * and than use them to calculate chess rolls using  ({@link #getChessRoll(Race)}) method
     *
     * @param carClassCompetition Object defines by what car class competition  we want to get the chess rolls.
     * @return List of chess rolls  in this car class competition.
     * @author Volodmyr Slobodian
     */
    public List<List<Set<Integer>>> getChessRollsByCarClassCompetition(CarClassCompetition carClassCompetition);

    /**
     * This method sets the number of race depending on amount of already finished.
     * <p/>
     * This method checks if there no races in database.
     * If not, race will be assigned the number 1, otherwise - number 2.
     *
     * @param carClassCompetition Object defines by what car class competition  we want to set the race number.
     * @param race                Object defines in which race we want to set the race number.
     * @author Volodmyr Slobodian
     */
    public void setRaceNumber(CarClassCompetition carClassCompetition, Race race);

    /**
     * This method return the race object depending on car class competition and race number.
     * <p/>
     * This method checks if there no races in database.
     * If not, race will be assigned the number 1, otherwise - number 2.
     *
     * @param raceNumber          int number defines by which race number we want to get the race object.
     * @param carClassCompetition Object defines by what car class competition  we want to get the race object.
     * @return Race object specified by car class competition and race number.
     * @author Volodmyr Slobodian
     */
    public Race getRaceByNumberAndCarClassCompetition(int raceNumber, CarClassCompetition carClassCompetition);
}
