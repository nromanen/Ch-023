package net.carting.service;

import net.carting.dao.CarClassCompetitionDAO;
import net.carting.dao.RacerCarClassCompetitionNumberDAO;
import net.carting.domain.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Service
public class CarClassCompetitionServiceImpl implements CarClassCompetitionService {

	private static final Logger LOG = LoggerFactory.getLogger(CarClassCompetitionServiceImpl.class);
	
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
    public List<CarClassCompetition> getCarClassCompetitionsByCompetitionId(int competitionId) {
        return carClassCompetitionDAO.getCarClassCompetitionsByCompetitionId(competitionId);
    }

    @Override
    @Transactional
    public List<CarClassCompetition> getCarClassCompetitionsByCarClassId(int carClassId) {
        return carClassCompetitionDAO.getCarClassCompetitionsByCarClassId(carClassId);
    }

    @Override
    @Transactional
    public List<Racer> getNotValidRacersToRegistration(int carClassCompetitionId, Team team) {
    	
    	
    	LOG.debug("Start getNotValidRacersToRegistration method");
        List<Racer> racers = new ArrayList<Racer>();

        LOG.debug("put already registred users");
        List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumbers =
                racerCarClassCompetitionNumberDAO.getRacerCarClassCompetitionNumbersByCarClassCompetitionIdAndTeamId(
                        carClassCompetitionId, team.getId());

        for (int i = 0; i < racerCarClassCompetitionNumbers.size(); i++) {
            Racer racer = racerCarClassCompetitionNumbers.get(i).getRacer();
            racers.add(racer);
        }
        //-----------------------------

        LOG.debug("put racers who dont have current carclass and put disabled racers");
        CarClass carClass = carClassCompetitionDAO.getCarClassCompetitionById(carClassCompetitionId).getCarClass();
        Set<Racer> teamRacers = team.getRacers();
        for (Racer racer : teamRacers) {
            boolean isContainsCarClass = false;
            if (racer.isEnabled()) { 
            	LOG.debug("if racer not disabled - checking if he has specific car class");
                Set<RacerCarClassNumber> racerCarClassNumbers = racer.getCarClassNumbers();
                for (RacerCarClassNumber racerCarClassNumber : racerCarClassNumbers) {
                    CarClass racerCarClass = racerCarClassNumber.getCarClass();
                    if (racerCarClass.equals(carClass) && (racer.getAge() >= racerCarClass.getLowerYearsLimit()) &&
                                            (racer.getAge() <= racerCarClass.getUpperYearsLimit())) {
                            isContainsCarClass = true;
                            break;
                    }
                }
            }
            if (!isContainsCarClass) {
                racers.add(racer);
            }
        }
        //-----------------------------------------
        LOG.debug("End getNotValidRacersToRegistration method");
        return racers;
    }

}
