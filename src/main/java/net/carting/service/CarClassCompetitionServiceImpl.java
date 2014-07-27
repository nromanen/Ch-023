package net.carting.service;

import net.carting.dao.CarClassCompetitionDAO;
import net.carting.dao.RacerCarClassCompetitionNumberDAO;
import net.carting.domain.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Service
public class CarClassCompetitionServiceImpl implements CarClassCompetitionService {

    @Autowired
    private CarClassCompetitionDAO carClassCompetitionDAO;

    @Autowired
    private RacerCarClassCompetitionNumberDAO racerCarClassCompetitionNumberDAO;

    @Override
    @Transactional
    public List<CarClassCompetition> getAllCarClassCompetitions() {
        return carClassCompetitionDAO.getAllCarClassCompetitions();
    }

    @Override
    @Transactional
    public CarClassCompetition getCarClassCompetitionById(int id) {
        return carClassCompetitionDAO.getCarClassCompetitionById(id);
    }

    @Override
    @Transactional
    public void addCarClassCompetition(CarClassCompetition carClassCompetition) {
        carClassCompetitionDAO.addCarClassCompetition(carClassCompetition);
    }

    @Override
    @Transactional
    public void updateCarClassCompetition(CarClassCompetition carClassCompetition) {
        carClassCompetitionDAO.updateCarClassCompetition(carClassCompetition);
    }

    @Override
    @Transactional
    public void deleteCarClassCompetition(CarClassCompetition carClassCompetition) {
        carClassCompetitionDAO.deleteCarClassCompetition(carClassCompetition);
    }

    @Override
    @Transactional
    public List<CarClassCompetition> getCarClassCompetitionsByCompetitionId(int competitonId) {
        return carClassCompetitionDAO.getCarClassCompetitionsByCompetitionId(competitonId);
    }

    @Override
    @Transactional
    public List<CarClassCompetition> getCarClassCompetitionsByCarClassId(int carClassId) {
        return carClassCompetitionDAO.getCarClassCompetitionsByCarClassId(carClassId);
    }

    @Override
    @Transactional
    public List<Racer> getNotValidRacersToRegistration(int carClassCompetitionId, Team team) {

        List<Racer> racers = new ArrayList<Racer>();

        // put already registred users
        List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumbers =
                racerCarClassCompetitionNumberDAO.getRacerCarClassCompetitionNumbersByCarClassCompetitionIdAndTeamId(
                        carClassCompetitionId, team.getId());

        for (int i = 0; i < racerCarClassCompetitionNumbers.size(); i++) {
            Racer racer = racerCarClassCompetitionNumbers.get(i).getRacer();
            racers.add(racer);
        }
        //-----------------------------

        // put racers who dont have current carclass and put disabled racers
        CarClass carClass = carClassCompetitionDAO.getCarClassCompetitionById(carClassCompetitionId).getCarClass();
        Set<Racer> teamRacers = team.getRacers();
        for (Racer racer : teamRacers) {
            boolean isContainsCarClass = false;
            if (racer.isEnabled()) { // if racer not disabled - checking if he has specific car class
                Set<RacerCarClassNumber> racerCarClassNumbers = racer.getCarClassNumbers();
                for (RacerCarClassNumber racerCarClassNumber : racerCarClassNumbers) {
                    CarClass racerCarClass = racerCarClassNumber.getCarClass();
                    if (racerCarClass.equals(carClass)) {
                        if ((racer.getAge() >= racerCarClass.getLowerYearsLimit()) &&
                                (racer.getAge() <= racerCarClass.getUpperYearsLimit())) {
                            isContainsCarClass = true;
                            break;
                        }
                    }
                }
            }
            if (!isContainsCarClass) {
                racers.add(racer);
            }
        }
        //-----------------------------------------

        return racers;
    }

}
