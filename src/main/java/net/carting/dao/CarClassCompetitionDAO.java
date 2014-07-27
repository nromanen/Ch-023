package net.carting.dao;

import net.carting.domain.CarClassCompetition;

import java.util.List;

public interface CarClassCompetitionDAO {

    public List<CarClassCompetition> getAllCarClassCompetitions();

    public CarClassCompetition getCarClassCompetitionById(int id);

    public void addCarClassCompetition(CarClassCompetition carClassCompetition);

    public void updateCarClassCompetition(CarClassCompetition carClassCompetition);

    public void deleteCarClassCompetition(CarClassCompetition carClassCompetition);

    public List<CarClassCompetition> getCarClassCompetitionsByCompetitionId(int competitionId);

    public List<CarClassCompetition> getCarClassCompetitionsByCarClassId(int carClassId);

}
