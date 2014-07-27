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
}
