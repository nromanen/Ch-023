package net.carting.service;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.CarClassCompetitionResult;
import net.carting.domain.Race;

import java.util.List;

public interface CarClassCompetitionResultService {

    public List<CarClassCompetitionResult> getAllCarClassCompetitionResults();

    public CarClassCompetitionResult getCarClassCompetitionResultById(int id);

    public void addCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult);

    public void updateCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult);

    public void deleteCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult);

    public void setAbsoluteResults(CarClassCompetition carClassCompetition, Race race);

    public List<CarClassCompetitionResult> getCarClassCompetitionResultsByCarClassCompetition(CarClassCompetition carClassCompetition);

    public List<CarClassCompetitionResult> getCarClassCompetitionResultsOrderedByPoints(CarClassCompetition carClassCompetition);

    public void recalculateAbsoluteResults(CarClassCompetition carClassCompetition);

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
