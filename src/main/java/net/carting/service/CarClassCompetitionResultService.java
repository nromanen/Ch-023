package net.carting.service;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.CarClassCompetitionResult;
import net.carting.domain.Race;

import java.util.List;

public interface CarClassCompetitionResultService {

    /**
     * This method returns all summary results.
     * <p/>
     * This method returns all summary results by all competitions
     *
     * @return List of car class competition result objects.
     */
    public List<CarClassCompetitionResult> getAllCarClassCompetitionResults();

    /**
     * This method gets the total result by car class competition result id.
     * <p/>
     * This method gets the total result by car class competition result id
     * given as parameter.
     *
     * @param id
     *            Id of CarClassCompetitionResult by which we want to get the
     *            object.
     * @return Object of car class competition result.
     */
    public CarClassCompetitionResult getCarClassCompetitionResultById(int id);

    /**
     * This method adds the total result.
     * <p/>
     * This method adds the total result given as a parameter.
     *
     * @param carClassCompetitionResult
     *            Object of CarClassCompetitionResult which we want to add
     * @author Volodmyr Slobodian
     */
    public void addCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult);

    /**
     * This method updates the total result.
     * <p/>
     * This method updates the total result given as a parameter.
     *
     * @param carClassCompetitionResult
     *            Object of CarClassCompetitionResult which we want to update
     * @author Volodmyr Slobodian
     */
    public void updateCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult);

    /**
     * This method deletes the total result.
     * <p/>
     * This method deletes the total result given as a parameter.
     *
     * @param carClassCompetitionResult
     *            Object of CarClassCompetitionResult which we want to delete
     * @author Volodmyr Slobodian
     */
    public void deleteCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult);

    /**
     * This method calculates and records the total results.
     * <p/>
     * This method calculates and records the total results depending on race
     * number. If the race number equals 1, the object is created and overall
     * results recorded zero values​​. Then there are recorded the results of
     * the first race. If the race number equals 2, we get the summary results
     * by car class competition and add the results from second race. Then we
     * use (@link #recalculateAbsoluteResults(CarClassCompetition)) method to
     * recalculate places by summary points.
     *
     * @param carClassCompetition
     *            Car class competition in which we want to calculate summary
     *            results
     * @param race
     *            Object that defines by what race we want to calculate results
     * @author Volodmyr Slobodian
     */
    public void setAbsoluteResults(CarClassCompetition carClassCompetition, Race race);

    /**
     * This method gets the total results by specified car class competition.
     *
     * @param carClassCompetition
     *            Car class competition by what we want to get total results
     * @return Return the list of total results in this car class competition
     * @author Volodmyr Slobodian
     */
    public List<CarClassCompetitionResult> getCarClassCompetitionResultsByCarClassCompetition(CarClassCompetition carClassCompetition);

    public List<CarClassCompetitionResult> getCarClassCompetitionResultsOrderedByPoints(CarClassCompetition carClassCompetition);

    /**
     * This method recalculates and updates the total results.
     * <p/>
     * This method recalculates and updates the total results. We must call this
     * method if total points were changed. In this method, we have overrided
     * Comprator to specify that the equality of the total points on the best
     * place would be the one who in the second race got more points. After
     * sorting by decay we recalculate places by points.
     *
     * @param carClassCompetition
     *            Car class competition in which we want to recalculate summary
     *            results
     */
    public void recalculateAbsoluteResults(CarClassCompetition carClassCompetition);


    /**
     * This method recalculates and updates the total results if one race was
     * edited.
     * <p/>
     * This method recalculates and updates the total results if one race was
     * edited.
     *
     * @param carClassCompetition
     *            Car class competition in which we want to recalculate summary
     *            results
     * @param race
     *            Object that defines by what race we want to recalculate
     *            results
     */
    public void recalculateAbsoluteResultsByEditedRace(CarClassCompetition carClassCompetition, Race race);

    List<Integer> getQualifyingPlacesByCarClassCompetition(
            CarClassCompetition ccc);

    List<Integer> getQualifyingTimesByCarClassCompetition(
            CarClassCompetition ccc);

    List<Integer> getAllQualifyingPlaces();

    List<Integer> getAllQualifyingTimes();

    void setQualifyingTime(CarClassCompetitionResult cccResult, int time);

    void setQualifyingPlace(CarClassCompetitionResult cccResult, int place);

    boolean setQualifyingTimeFromString(CarClassCompetitionResult cccRes,
            String timeString);

    List<Integer> getRacersNumbersWithSameQualifyingTime(CarClassCompetition ccc);

    void setQualifyingPlacesInCarClassCompetition(CarClassCompetition ccc);

    boolean isSetQualifyingByCarClassCompetition(CarClassCompetition ccc);

    List<CarClassCompetitionResult> getCarClassCompetitionResultsOrderedByQualifyingTimes(
            CarClassCompetition carClassCompetition);
}
