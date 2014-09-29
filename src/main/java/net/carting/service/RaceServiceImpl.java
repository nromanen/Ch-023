package net.carting.service;

import net.carting.dao.RaceDAO;
import net.carting.domain.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.PersistenceException;
import java.util.*;
import java.util.Map.Entry;

@Service
public class RaceServiceImpl implements RaceService {

	private static final Logger LOG = LoggerFactory.getLogger(RaceServiceImpl.class);
	
    @Autowired
    private RaceDAO raceDAO;

    @Autowired
    private RacerCarClassNumberService racerCarClassNumberService;

    @Autowired
    private RaceResultService raceResultService;

    @Autowired
    private RacerCarClassCompetitionNumberService racerCarClassCompetitionNumberService;

    @Autowired
    private CompetitionService competitionService;


    @Override
    @Transactional
    public List<Race> getAllRaces() {
        return raceDAO.getAllRaces();
    }

    @Override
    @Transactional
    public Race getRaceById(int id) {
        return raceDAO.getRaceById(id);
    }

    @Override
    @Transactional
    public void addRace(Race race) {
        raceDAO.addRace(race);
    }

    @Override
    @Transactional
    public void updateRace(Race race) {
        raceDAO.updateRace(race);
    }

    @Override
    @Transactional
    public void deleteRace(Race race) {
        raceDAO.deleteRace(race);
    }

    @Override
    public List<Set<Integer>> getChessRoll(Race race) {
    	LOG.debug("Start getChessRoll method");
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
                        } else {
                            break;
                        }
                    }
                    chessRoll.get(lapIndex).add(carNumber);
                    break;
                }
            }
        }
        LOG.debug("End getChessRoll method");
        return chessRoll;
    }

    @Override
    public void setResultTable(List<Set<Integer>> chessRoll,
                               Race race) {
    	LOG.debug("Start setResultTable method");
        try {
            Map<Integer, Integer> resultFullLaps = new LinkedHashMap<Integer, Integer>();
            Map<Integer, Integer> resultPoints = new LinkedHashMap<Integer, Integer>();
            Map<Integer, Racer> numbersAndRacersMap = new LinkedHashMap<Integer, Racer>();
            Map<Integer, Integer> numbersAndPlacesMap = new LinkedHashMap<Integer, Integer>();
            List<RacerCarClassCompetitionNumber> racersByClassCompetition = racerCarClassCompetitionNumberService.
                    getRacerCarClassCompetitionNumbersByCarClassCompetitionId(race.getCarClassCompetition().getId());

            for (int lapIndex = race.getNumberOfLaps() - 1; lapIndex >= 0; lapIndex--) {
                for (Integer carNumber : chessRoll.get(lapIndex)) {
                    if (!resultFullLaps.containsKey(carNumber)) {
                        resultFullLaps.put(carNumber, lapIndex + 1);
                    }
                }
            }

            for (RacerCarClassCompetitionNumber racer : racersByClassCompetition) {
                Integer carNumber = racer.getNumberInCompetition();
                if (!resultFullLaps.containsKey(carNumber)) {
                    resultFullLaps.put(carNumber, 0);
                    resultPoints.put(carNumber, 0);
                }
            }

            for (RacerCarClassCompetitionNumber numberAndRacer : racersByClassCompetition) {
                numbersAndRacersMap.put(numberAndRacer.getNumberInCompetition(),
                        numberAndRacer.getRacer());
                resultPoints.put(numberAndRacer.getNumberInCompetition(), 0);
            }
            List<String> pointsList;
            if (race.getCarClassCompetition().getCompetition().isCalculateByTableB()) {
            	pointsList = Arrays.asList(AdminSettings.POINTS_BY_TABLE_B.get(racersByClassCompetition.size()).split(","));
            } else {
            	pointsList = competitionService.getPointsByPlacesList(race.getCarClassCompetition().getCompetition());
            }
            
            int place = 1;
            for (Entry<Integer, Integer> entry : resultFullLaps.entrySet()) {
                numbersAndPlacesMap.put(entry.getKey(), place);
                if (place <= pointsList.size()) {
                    resultPoints.put(entry.getKey(), Integer.parseInt(pointsList.get(place - 1)));
                }
                place++;
            }

            List<RaceResult> resultsList = raceResultService.getRaceResultsByRace(race);
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
                    try {
                        raceResultService.addRaceResult(raceResult);
                    } catch (PersistenceException e) {
                        LOG.error("Errors in setResultTable method during adding race results", e);
                    }
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
        	LOG.error("Error has occured in setResultTable method", e);
        }
        LOG.debug("End setResultTable method");
    }

    public List<RaceResult> getResultTable(Race race) {
        return raceResultService.getRaceResultsByRace(race);
    }

    public List<Integer> getNumbersArrayByCarClass(CarClass carClass) {

        List<RacerCarClassNumber> racersAndNumbersByClass = racerCarClassNumberService
                .getNumbersByCarClass(carClass);
        List<Integer> numbers = new ArrayList<Integer>();

        for (RacerCarClassNumber raceAndNumber : racersAndNumbersByClass) {
            numbers.add(raceAndNumber.getNumber());
        }
        return numbers;
    }

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

    @Override
    @Transactional
    public List<Race> getRacesByCarClassCompetition(
            CarClassCompetition carClassCompetition) {
        return raceDAO.getRacesByCarClassCompetition(carClassCompetition);
    }

    @Override
    @Transactional
    public List<List<RaceResult>> getRaceResultsByCarClassCompetition(
            CarClassCompetition carClassCompetition) {

        List<List<RaceResult>> raceResultsList = new ArrayList<List<RaceResult>>();

        List<Race> raceList = raceDAO
                .getRacesByCarClassCompetition(carClassCompetition);

        for (Race race : raceList) {
            raceResultsList.add(raceResultService.getRaceResultsByRace(race));
        }

        return raceResultsList;
    }

    @Override
    @Transactional
    public List<List<Set<Integer>>> getChessRollsByCarClassCompetition(
            CarClassCompetition carClassCompetition) {
        List<List<Set<Integer>>> chessRollsList = new ArrayList<List<Set<Integer>>>();
        List<Race> raceList = raceDAO.getRacesByCarClassCompetition(carClassCompetition);

        for (Race race : raceList) {
            chessRollsList.add(getChessRoll(race));
        }
        return chessRollsList;
    }

    @Override
    @Transactional
    public void setRaceNumber(CarClassCompetition carClassCompetition, Race race) {
        List<Race> raceList = raceDAO
                .getRacesByCarClassCompetition(carClassCompetition);
        if (raceList.size() == 0) {
            race.setRaceNumber(1);
        } else {
            race.setRaceNumber(2);
        }
    }

    @Override
    @Transactional
    public Race getRaceByNumberAndCarClassCompetition(int raceNumber,
                                                      CarClassCompetition carClassCompetition) {
        return raceDAO.getRaceByNumberAndCarClassCompetition(raceNumber, carClassCompetition);
    }

}
