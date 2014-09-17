package net.carting.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Set;

import net.carting.dao.CarClassCompetitionResultDAO;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.CarClassCompetitionResult;
import net.carting.domain.Competition;
import net.carting.domain.Qualifying;
import net.carting.domain.Race;
import net.carting.domain.RaceResult;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassCompetitionNumber;
import net.carting.util.DateUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CarClassCompetitionResultServiceImpl implements
        CarClassCompetitionResultService {

    private static final Logger LOG = LoggerFactory
            .getLogger(CarClassCompetitionResultServiceImpl.class);

    @Autowired
    private CarClassCompetitionResultDAO carClassCompetitionResultDAO;

    @Autowired
    private RacerCarClassCompetitionNumberService racerCarClassCompetitionNumberService;

    @Autowired
    private RaceResultService raceResultService;

    @Autowired
    private RaceService raceService;

    @Autowired
    private CompetitionService competitionService;

    /**
     * This method returns all summary results.
     * <p/>
     * This method returns all summary results by all competitions
     *
     * @return List of car class competition result objects.
     * @author Volodmyr Slobodian
     */

    @Override
    @Transactional
    public List<CarClassCompetitionResult> getAllCarClassCompetitionResults() {
        return carClassCompetitionResultDAO.getAllCarClassCompetitionResults();
    }

    /**
     * This method gets the total result by car class competition result id.
     * <p/>
     * This method gets the total result by car class competition result id
     * given as parameter.
     *
     * @param carClassCompetitionResultId
     *            Id of CarClassCompetitionResult by which we want to get the
     *            object.
     * @return Object of car class competition result.
     * @author Volodmyr Slobodian
     */

    @Override
    @Transactional
    public CarClassCompetitionResult getCarClassCompetitionResultById(int id) {
        return carClassCompetitionResultDAO
                .getCarClassCompetitionResultById(id);
    }

    /**
     * This method adds the total result.
     * <p/>
     * This method adds the total result given as a parameter.
     *
     * @param carClassCompetitionResult
     *            Object of CarClassCompetitionResult which we want to add
     * @author Volodmyr Slobodian
     */
    @Override
    @Transactional
    public void addCarClassCompetitionResult(
            CarClassCompetitionResult carClassCompetitionResult) {
        carClassCompetitionResultDAO
                .addCarClassCompetitionResult(carClassCompetitionResult);
    }

    /**
     * This method updates the total result.
     * <p/>
     * This method updates the total result given as a parameter.
     *
     * @param carClassCompetitionResult
     *            Object of CarClassCompetitionResult which we want to update
     * @author Volodmyr Slobodian
     */
    @Override
    @Transactional
    public void updateCarClassCompetitionResult(
            CarClassCompetitionResult carClassCompetitionResult) {
        carClassCompetitionResultDAO
                .updateCarClassCompetitionResult(carClassCompetitionResult);
    }

    /**
     * This method deletes the total result.
     * <p/>
     * This method deletes the total result given as a parameter.
     *
     * @param carClassCompetitionResult
     *            Object of CarClassCompetitionResult which we want to delete
     * @author Volodmyr Slobodian
     */
    @Override
    @Transactional
    public void deleteCarClassCompetitionResult(
            CarClassCompetitionResult carClassCompetitionResult) {
        carClassCompetitionResultDAO
                .deleteCarClassCompetitionResult(carClassCompetitionResult);
    }

    /**
     * This method gets the total results by specified car class competition.
     *
     * @param carClassCompetition
     *            Car class competition by what we want to get total results
     * @return Return the list of total results in this car class competition
     * @author Volodmyr Slobodian
     */
    @Override
    @Transactional
    public List<CarClassCompetitionResult> getCarClassCompetitionResultsByCarClassCompetition(
            CarClassCompetition carClassCompetition) {

        return carClassCompetitionResultDAO
                .getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition);
    }

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
     * @param Race
     *            Object that defines by what race we want to calculate results
     * @author Volodmyr Slobodian
     */

    @Override
    @Transactional
    public void setAbsoluteResults(CarClassCompetition carClassCompetition,
            Race race) {
        LOG.debug("Start of setAbsoluteResults method");
        List<CarClassCompetitionResult> cccResList = getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition);
        List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumberList = racerCarClassCompetitionNumberService
                .getRacerCarClassCompetitionNumbersByCarClassCompetitionId(carClassCompetition
                        .getId());
        if (race.getRaceNumber() == 1) {
            Competition competition = carClassCompetition.getCompetition();
            competition.setEnabled(false);
            competitionService.updateCompetition(competition);
            for (int i=0;i<cccResList.size();i++) {
                CarClassCompetitionResult cccRes = cccResList.get(i);
                cccRes.setRacerCarClassCompetitionNumber(racerCarClassCompetitionNumberList.get(i));
                List<RaceResult> raceResults = (ArrayList<RaceResult>) raceResultService
                        .getRaceResultsByRace(race);
                for (RaceResult raceResult : raceResults) {
                    if (raceResult.getCarNumber() == cccRes.getRacerCarClassCompetitionNumber()
                            .getNumberInCompetition()) {
                        cccRes.setAbsolutePlace(raceResult
                                .getPlace());
                        cccRes.setAbsolutePoints(raceResult
                                .getPoints());
                    }
                }
                updateCarClassCompetitionResult(cccRes);
            }
            LOG.debug("There is one race in this competition");
        }
        // add results of race#2
        if (race.getRaceNumber() == 2) {
            List<CarClassCompetitionResult> absoluteResultsList = (List<CarClassCompetitionResult>) getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition);
            List<RaceResult> raceResults = (List<RaceResult>) raceResultService
                    .getRaceResultsByRace(race);

            for (RaceResult raceResult : raceResults) {
                for (CarClassCompetitionResult carClassCompetitionResult : absoluteResultsList) {
                    if (raceResult.getCarNumber() == carClassCompetitionResult
                            .getRacerCarClassCompetitionNumber()
                            .getNumberInCompetition()) {
                        carClassCompetitionResult
                                .setAbsolutePoints(raceResult.getPoints()
                                        + carClassCompetitionResult
                                                .getAbsolutePoints());
                        carClassCompetitionResult.setRace2points(raceResult
                                .getPoints());
                        updateCarClassCompetitionResult(carClassCompetitionResult);
                    }
                }
            }
            recalculateAbsoluteResults(carClassCompetition);
            LOG.debug("There are two races in this competition");
        }
        LOG.debug("End of setAbsoluteResults method");
    }

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
     * @param Race
     *            Object that defines by what race we want to recalculate
     *            results
     * @author Volodmyr Slobodian
     */

    @Override
    @Transactional
    public void recalculateAbsoluteResultsByEditedRace(
            CarClassCompetition carClassCompetition, Race race) {
        LOG.debug("Start of recalculateAbsoluteResultsByEditedRace method, that recalculate absolute results after race results was edited");
        List<CarClassCompetitionResult> absoluteResultsList = (List<CarClassCompetitionResult>) getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition);
        List<List<RaceResult>> raceResultsList = raceService
                .getRaceResultsByCarClassCompetition(carClassCompetition);
        for (CarClassCompetitionResult carClassCompetitionResult : absoluteResultsList) {
            carClassCompetitionResult.setAbsolutePoints(0);
        }

        for (CarClassCompetitionResult carClassCompetitionResult : absoluteResultsList) {
            for (List<RaceResult> raceResults : raceResultsList) {
                for (RaceResult raceResult : raceResults) {
                    if (raceResult.getCarNumber() == carClassCompetitionResult
                            .getRacerCarClassCompetitionNumber()
                            .getNumberInCompetition()) {
                        carClassCompetitionResult
                                .setAbsolutePoints(raceResult.getPoints()
                                        + carClassCompetitionResult
                                                .getAbsolutePoints());
                        if (raceResult.getRace().getRaceNumber() == 2) {
                            carClassCompetitionResult.setRace2points(raceResult
                                    .getPoints());
                        }
                    }
                }
            }
            updateCarClassCompetitionResult(carClassCompetitionResult);
        }
        recalculateAbsoluteResults(carClassCompetition);
        LOG.debug("End of recalculateAbsoluteResultsByEditedRace method");
    }

    @Override
    @Transactional
    public List<CarClassCompetitionResult> getCarClassCompetitionResultsOrderedByPoints(
            CarClassCompetition carClassCompetition) {

        return carClassCompetitionResultDAO
                .getCarClassCompetitionResultsOrderedByPoints(carClassCompetition);
    }

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
     * @author Volodmyr Slobodian
     */

    @Override
    @Transactional
    public void recalculateAbsoluteResults(
            CarClassCompetition carClassCompetition) {

        LOG.debug("Start of recalculateAbsoluteResults method that overrides comparator for absolute results.");
        List<CarClassCompetitionResult> orderedAbsoluteResultsList = (List<CarClassCompetitionResult>) getCarClassCompetitionResultsOrderedByPoints(carClassCompetition);
        Collections.sort(orderedAbsoluteResultsList,
                new Comparator<CarClassCompetitionResult>() {
                    @Override
                    public int compare(
                            CarClassCompetitionResult summaryResult1,
                            CarClassCompetitionResult summaryResult2) {
                        if (summaryResult1.getAbsolutePoints() == summaryResult2
                                .getAbsolutePoints()) {
                            // get racers for absoluteResult1 and
                            // absoluteResult2
                            Racer racer1 = summaryResult1
                                    .getRacerCarClassCompetitionNumber()
                                    .getRacer();
                            Racer racer2 = summaryResult2
                                    .getRacerCarClassCompetitionNumber()
                                    .getRacer();
                            // get all races results of which are used in
                            // calculation of absolute results
                            Set<Race> races1 = summaryResult1
                                    .getRacerCarClassCompetitionNumber()
                                    .getCarClassCompetition().getRaces();
                            Set<Race> races2 = summaryResult2
                                    .getRacerCarClassCompetitionNumber()
                                    .getCarClassCompetition().getRaces();
                            List<RaceResult> raceResults1 = new ArrayList<RaceResult>();
                            List<RaceResult> raceResults2 = new ArrayList<RaceResult>();
                            // get all results which are used in calculation of
                            // absolute results
                            for (Race race : races1) {
                                raceResults1.add(raceResultService
                                        .getRaceResultsByRaceAndRacer(race,
                                                racer1));
                            }
                            for (Race race : races2) {
                                raceResults2.add(raceResultService
                                        .getRaceResultsByRaceAndRacer(race,
                                                racer2));
                            }
                            // get the best place in two races
                            int min1 = Math.min(raceResults1.get(0).getPlace(),
                                    raceResults1.get(1).getPlace());
                            int min2 = Math.min(raceResults2.get(0).getPlace(),
                                    raceResults2.get(1).getPlace());
                            if (min1 != min2) {
                                return min1 < min2 ? -1 : 1;
                            }
                            // get the worst place in two races
                            int max1 = Math.max(raceResults1.get(0).getPlace(),
                                    raceResults1.get(1).getPlace());
                            int max2 = Math.max(raceResults2.get(0).getPlace(),
                                    raceResults2.get(1).getPlace());
                            if (max1 != max2) {
                                return max1 > max2 ? 1 : -1;
                            }

                            return summaryResult1.getRace2points() > summaryResult2
                                    .getRace2points() ? -1 : 1;
                        }
                        return summaryResult1.getAbsolutePoints() > summaryResult2
                                .getAbsolutePoints() ? -1 : 1;
                    }
                });

        int place = 1;
        for (CarClassCompetitionResult carClassCompetitionResult : orderedAbsoluteResultsList) {
            carClassCompetitionResult.setAbsolutePlace(place);
            updateCarClassCompetitionResult(carClassCompetitionResult);
            place++;
        }
        LOG.debug("End of recalculateAbsoluteResults method");

    }

    @Override
    @Transactional
    public List<Integer> getAllQualifyingTimes() {
        List<Integer> allQualifyings = new ArrayList<Integer>();
        for (CarClassCompetitionResult res : getAllCarClassCompetitionResults()) {
            allQualifyings.add(res.getQualifyingRacerTime());
        }
        if (!allQualifyings.isEmpty()) {
            return allQualifyings;
        } else {
            return null;
        }
    }

    @Override
    @Transactional
    public List<Integer> getAllQualifyingPlaces() {
        List<Integer> allQualifyings = new ArrayList<Integer>();
        for (CarClassCompetitionResult res : getAllCarClassCompetitionResults()) {
            allQualifyings.add(res.getQualifyingRacerPlace());
        }
        if (!allQualifyings.isEmpty()) {
            return allQualifyings;
        } else {
            return null;
        }
    }

    @Override
    @Transactional
    public List<Integer> getQualifyingPlacesByCarClassCompetition(
            CarClassCompetition ccc) {
        List<Integer> allQualifyings = new ArrayList<Integer>();

        for (CarClassCompetitionResult res : getCarClassCompetitionResultsByCarClassCompetition(ccc)) {
            if(res.getQualifyingRacerPlace()!=null) {
                allQualifyings.add(res.getQualifyingRacerPlace());
            }
        }
        if (!allQualifyings.isEmpty()) {
            return allQualifyings;
        } else {
            return null;
        }
    }

    @Override
    @Transactional
    public List<Integer> getQualifyingTimesByCarClassCompetition(
            CarClassCompetition ccc) {
        List<Integer> allQualifyings = new ArrayList<Integer>();

        for (CarClassCompetitionResult res : getCarClassCompetitionResultsByCarClassCompetition(ccc)) {
            if(res.getQualifyingRacerTime()!=null) {
                allQualifyings.add(res.getQualifyingRacerTime());
            }
        }
        if (!allQualifyings.isEmpty()) {
            return allQualifyings;
        } else {
            return null;
        }
    }

    @Override
    @Transactional
    public void setQualifyingTime(CarClassCompetitionResult cccResult, int time) {
        getCarClassCompetitionResultById(cccResult.getId())
                .setQualifyingRacerTime(time);
        updateCarClassCompetitionResult(cccResult);
    }

    @Override
    @Transactional
    public void setQualifyingPlace(CarClassCompetitionResult cccResult,
            int place) {
        getCarClassCompetitionResultById(cccResult.getId())
                .setQualifyingRacerPlace(place);
        updateCarClassCompetitionResult(cccResult);
    }

    @Override
    @Transactional
    public boolean setQualifyingTimeFromString(
            CarClassCompetitionResult cccRes, String timeString) {
        int timeInt = 0;
        if (!timeString
                .matches("((\\d?\\d:)?[0-5]?\\d:)?[0-5]?\\d(\\.\\d{1,3})?")) {
            return false;
        }
        try {
            timeInt = DateUtil.getIntFromTimeString(timeString);
            cccRes.setQualifyingRacerTime(timeInt);
            updateCarClassCompetitionResult(cccRes);
        } catch (IllegalArgumentException e) {
            LOG.error("Errors in setQualifyingTimeFromString method.", e);
            return false;
        }
        return true;
    }

    @Override
    @Transactional
    public List<Integer> getRacersNumbersWithSameQualifyingTime(
            CarClassCompetition ccc) {
        if(getQualifyingTimesByCarClassCompetition(ccc)!=null&&getQualifyingTimesByCarClassCompetition(ccc).size()>1) {
            List<CarClassCompetitionResult> ques = getCarClassCompetitionResultsByCarClassCompetition(ccc);
            List<Integer> qNums = new ArrayList<Integer>();
            for (int i = 0; i < ques.size() - 1; i++) {
                for (int j = i + 1; j < ques.size(); j++) {
                    if (ques.get(i).getQualifyingRacerTime()
                            .equals(ques.get(j).getQualifyingRacerTime())) {
                        if (!qNums.contains(ques.get(i)
                                .getRacerCarClassCompetitionNumber()
                                .getNumberInCompetition())) {
                            qNums.add(ques.get(i)
                                    .getRacerCarClassCompetitionNumber()
                                    .getNumberInCompetition());
                        }
                        if (!qNums.contains(ques.get(j)
                                .getRacerCarClassCompetitionNumber()
                                .getNumberInCompetition())) {
                            qNums.add(ques.get(j)
                                    .getRacerCarClassCompetitionNumber()
                                    .getNumberInCompetition());
                        }
    
                    }
                }
            }
            return qNums;
        } else {
            return null;
        }
    }

    @Override
    @Transactional
    public void setQualifyingPlacesInCarClassCompetition(CarClassCompetition ccc) {
        List<CarClassCompetitionResult> qList = getCarClassCompetitionResultsByCarClassCompetition(ccc);
        while (!qList.isEmpty()) {
            CarClassCompetitionResult cccRes = qList.get(0);
            for (int j = 1; j < qList.size(); j++) {
                if (cccRes.getQualifyingRacerTime() < qList.get(j)
                        .getQualifyingRacerTime()) {
                    cccRes = qList.get(j);
                }
            }
            cccRes.setQualifyingRacerPlace(qList.size());
            updateCarClassCompetitionResult(cccRes);
            qList.remove(cccRes);
        }
    }
    
    @Override
    @Transactional
    public boolean isSetQualifyingByCarClassCompetition(CarClassCompetition ccc) {
        if(getQualifyingPlacesByCarClassCompetition(ccc)==null||
                getQualifyingTimesByCarClassCompetition(ccc).isEmpty()) {
            return false;
        } else {
            return true;
        }
    }
    
    @Override
    @Transactional
    public List<CarClassCompetitionResult> getCarClassCompetitionResultsOrderedByQualifyingTimes(
            CarClassCompetition carClassCompetition) {
        return carClassCompetitionResultDAO
                .getCarClassCompetitionResultsOrderedByQualifyingTimes(carClassCompetition);
    }
}
