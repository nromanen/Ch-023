package net.carting.service;

import net.carting.dao.RaceDAO;
import net.carting.dao.RacerDAO;
import net.carting.domain.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.Map.Entry;

@Service
public class RaceServiceImpl implements RaceService {

    @Autowired
    private RaceDAO raceDAO;

    @Autowired
    private RacerCarClassNumberService racerCarClassNumberService;

    @Autowired
    private RacerDAO racerDAO;

    @Autowired
    private RaceResultService raceResultService;

    @Autowired
    private RacerCarClassCompetitionNumberService racerCarClassCompetitionNumberService;

    @Autowired
    private AdminSettingsService adminSettingsService;


    /**
     * This method  returns all races
     * <p/>
     * This method returns all races by all competitions.
     *
     * @return List  of race objects.
     * @author Volodmyr Slobodian
     */
    @Override
    @Transactional
    public List<Race> getAllRaces() {
        return raceDAO.getAllRaces();
    }

    /**
     * This method  gets the race by  race id.
     * <p/>
     * This method  gets the race  by race id given as parameter.
     *
     * @param id Id of race by which we want to get the object.
     * @return Object of race.
     * @author Volodmyr Slobodian
     */
    @Override
    @Transactional
    public Race getRaceById(int id) {
        return raceDAO.getRaceById(id);
    }

    /**
     * This method  adds the race.
     * <p/>
     * This method adds the race given as a parameter.
     *
     * @param race Object of race which we want to add
     * @author Volodmyr Slobodian
     */
    @Override
    @Transactional
    public void addRace(Race race) {
        raceDAO.addRace(race);
    }

    /**
     * This method  updates the race.
     * <p/>
     * This method updates the race given as a parameter.
     *
     * @param race Object of race which we want to update.
     * @author Volodmyr Slobodian
     */
    @Override
    @Transactional
    public void updateRace(Race race) {
        raceDAO.updateRace(race);
    }

    /**
     * This method deletes the race.
     * <p/>
     * This method deletes the race given as a parameter.
     *
     * @param race Object of race which we want to update.
     * @author Volodmyr Slobodian
     */
    @Override
    @Transactional
    public void deleteRace(Race race) {
        raceDAO.deleteRace(race);
    }

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
    @Override
    public List<Set<Integer>> getChessRoll(Race race) {
        boolean isLastLap = false;
        String[] numberSequance = race.getResultSequance().trim().split("\\W+");
        int laps = race.getNumberOfLaps();
        Set<Integer> lastLap = new LinkedHashSet<Integer>();
        List<Set<Integer>> chessRoll = new ArrayList<Set<Integer>>(laps);

        for (int lapIndex = 0; lapIndex < laps; lapIndex++) {
            chessRoll.add(new LinkedHashSet<Integer>());
        }
        for (int numberInString = 0; numberInString < numberSequance.length; numberInString++) {
            int lapIndex;
            int carNumber = Integer.parseInt(numberSequance[numberInString]);
            for (lapIndex = 0; lapIndex < laps; lapIndex++) {
                if (!chessRoll.get(lapIndex).contains(carNumber)) {
                    if (lapIndex == laps - 1) {
                        isLastLap = true;
                    }
                    if (isLastLap) {
                        if (!lastLap.contains(carNumber)) {
                            lastLap.add(carNumber);
                        } else
                            break;
                    }
                    chessRoll.get(lapIndex).add(carNumber);
                    break;
                }
            }
        }
        return chessRoll;
    }

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
    @Override
    public void setResultTable(List<Set<Integer>> chessRoll,
                               Race race) {
        try {
            Map<Integer, Integer> resultFullLaps = new LinkedHashMap<Integer, Integer>();
            Map<Integer, Integer> resultPoints = new LinkedHashMap<Integer, Integer>();
            Map<Integer, Racer> numbersAndRacersMap = new LinkedHashMap<Integer, Racer>();
            Map<Integer, Integer> numbersAndPlacesMap = new LinkedHashMap<Integer, Integer>();
            List<RacerCarClassCompetitionNumber> racersByClassCompetition = racerCarClassCompetitionNumberService.
                    getRacerCarClassCompetitionNumbersByCarClassCompetitionId(race.getCarClassCompetition().getId());
            for (int lapIndex = race.getNumberOfLaps() - 1; lapIndex >= 0; lapIndex--) {
                Iterator<Integer> it = chessRoll.get(lapIndex).iterator();
                while (it.hasNext()) {
                    Integer carNumber = (Integer) it.next();
                    if (!resultFullLaps.containsKey(carNumber)) {
                        resultFullLaps.put(carNumber, lapIndex + 1);
                    }
                }
            }

            for (RacerCarClassCompetitionNumber numberAndRacer : racersByClassCompetition) {
                numbersAndRacersMap.put(numberAndRacer.getNumberInCompetition(),
                        numberAndRacer.getRacer());
                resultPoints.put(numberAndRacer.getNumberInCompetition(), 0);
            }

            List<String> pointsList = adminSettingsService.getPointsByPlacesList();
            int place = 1;
            for (Entry<Integer, Integer> entry : resultFullLaps.entrySet()) {
                numbersAndPlacesMap.put(entry.getKey(), place);
                if (place <= pointsList.size()) {
                    resultPoints.put(entry.getKey(), Integer.parseInt(pointsList.get(place - 1)));
                }
                place++;
            }

            List<RaceResult> resultsList = (ArrayList<RaceResult>) raceResultService.getRaceResultsByRace(race);
            if (resultsList.size() == 0) {
                for (Entry<Integer, Integer> entry : resultFullLaps.entrySet()) {
                    RaceResult raceResult = new RaceResult();
                    int number = entry.getKey();
                    raceResult.setFullLaps(entry.getValue());
                    raceResult.setPlace(numbersAndPlacesMap.get(number));
                    raceResult.setRace(race);
                    raceResult.setRacer(numbersAndRacersMap.get(number));
                    if (raceResult.getFullLaps() <= (race.getCarClassCompetition().getPercentageOffset() * 0.01) * (race.getNumberOfLaps())) {
                        raceResult.setPoints(0);
                    } else {
                        raceResult.setPoints(resultPoints.get(number));
                    }
                    raceResult.setCarNumber(number);
                    raceResultService.addRaceResult(raceResult);
                }
            } else {
                for (RaceResult raceResult : resultsList) {
                    int carNumber = raceResult.getCarNumber();
                    raceResult.setFullLaps(resultFullLaps.get(carNumber));
                    raceResult.setPlace(numbersAndPlacesMap.get(carNumber));
                    raceResult.setRace(race);
                    if (raceResult.getFullLaps() <= (race.getCarClassCompetition().getPercentageOffset() * 0.01) * (race.getNumberOfLaps())) {
                        raceResult.setPoints(0);
                    } else {
                        raceResult.setPoints(resultPoints.get(carNumber));
                    }
                    raceResultService.updateRaceResult(raceResult);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * This method gets list of results by specified race.
     * <p/>
     * This method gets list of results by specified race as a parameter.
     *
     * @param race Object that defines by what race we want to get results
     * @return List of race result objects
     * @author Volodmyr Slobodian
     */
    public List<RaceResult> getResultTable(Race race) {
        return raceResultService.getRaceResultsByRace(race);
    }

    /**
     * This method gets list of all racers numbers that are registered in this car class.
     * <p/>
     * This method gets list of all racers numbers that are registered in this car class.
     *
     * @param carClass Object that defines by what car class we want to get the numbers.
     * @return List of racer car numbers that are registered in this car class.
     * @author Volodmyr Slobodian
     */
    public List<Integer> getNumbersArrayByCarClass(CarClass carClass) {

        List<RacerCarClassNumber> racersAndNumbersByClass = racerCarClassNumberService
                .getNumbersByCarClass(carClass);
        List<Integer> numbers = new ArrayList<Integer>();

        for (RacerCarClassNumber raceAndNumber : racersAndNumbersByClass) {
            numbers.add(raceAndNumber.getNumber());
        }
        return numbers;
    }

    /**
     * This method gets list of all racers numbers that are registered in this car class competition.
     * <p/>
     * This method gets list of all racers numbers that are registered in this car class competition by id of that car class competition.
     *
     * @param carClassCompetitionId Id  of carClassCompetition defines by what car class competition  we want to get the numbers.
     * @return List of racer car numbers that are registered in this car class competition.
     * @author Volodmyr Slobodian
     */
    public List<Integer> getNumbersArrayByCarClassCompetitionId(Integer carClassCompetitionId) {

        List<RacerCarClassCompetitionNumber> racersAndNumbersByClassCompetition = racerCarClassCompetitionNumberService
                .getRacerCarClassCompetitionNumbersByCarClassCompetitionId(carClassCompetitionId);
        List<Integer> numbers = new ArrayList<Integer>();

        for (RacerCarClassCompetitionNumber raceAndNumber : racersAndNumbersByClassCompetition) {
            if (raceAndNumber.getRacer().isEnabled()) {
                numbers.add(raceAndNumber.getNumberInCompetition());
            }
        }
        return numbers;
    }

    /**
     * This method gets list of all races  in this car class competition.
     * <p/>
     * This method gets list of all races numbers  in this car class competition.
     *
     * @param carClassCompetition Object defines by what car class competition  we want to get the races.
     * @return List of races  in this car class competition.
     * @author Volodmyr Slobodian
     */

    @Override
    @Transactional
    public List<Race> getRacesByCarClassCompetition(
            CarClassCompetition carClassCompetition) {
        return raceDAO.getRacesByCarClassCompetition(carClassCompetition);
    }

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
    @Override
    @Transactional
    public List<List<RaceResult>> getRaceResultsByCarClassCompetition(
            CarClassCompetition carClassCompetition) {

        List<List<RaceResult>> raceResultsList = new ArrayList<List<RaceResult>>();

        List<Race> raceList = (ArrayList<Race>) raceDAO
                .getRacesByCarClassCompetition(carClassCompetition);

        for (Race race : raceList) {
            raceResultsList.add(raceResultService.getRaceResultsByRace(race));
        }

        return raceResultsList;
    }

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
    @Override
    @Transactional
    public List<List<Set<Integer>>> getChessRollsByCarClassCompetition(
            CarClassCompetition carClassCompetition) {
        List<List<Set<Integer>>> chessRollsList = new ArrayList<List<Set<Integer>>>();
        List<Race> raceList = (ArrayList<Race>) raceDAO.getRacesByCarClassCompetition(carClassCompetition);

        for (Race race : raceList) {
            chessRollsList.add(getChessRoll(race));
        }
        return chessRollsList;
    }

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
    @Override
    @Transactional
    public void setRaceNumber(CarClassCompetition carClassCompetition, Race race) {
        List<Race> raceList = (ArrayList<Race>) raceDAO
                .getRacesByCarClassCompetition(carClassCompetition);
        if (raceList.size() == 0) {
            race.setRaceNumber(1);
        } else {
            race.setRaceNumber(2);
        }
    }


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

    @Override
    @Transactional
    public Race getRaceByNumberAndCarClassCompetition(int raceNumber,
                                                      CarClassCompetition carClassCompetition) {
        return raceDAO.getRaceByNumberAndCarClassCompetition(raceNumber, carClassCompetition);
    }

}
