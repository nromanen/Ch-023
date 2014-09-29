package net.carting.service;

import net.carting.dao.RaceResultDAO;
import net.carting.domain.Race;
import net.carting.domain.RaceResult;
import net.carting.domain.Racer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class RaceResultServiceImpl implements RaceResultService {

    @Autowired
    private RaceResultDAO raceResultDAO;

    @Override
    @Transactional
    public List<RaceResult> getAllRaceResults() {
        return raceResultDAO.getAllRaceResults();
    }


    @Override
    @Transactional
    public RaceResult getRaceResultById(int id) {
        return raceResultDAO.getRaceResultById(id);
    }

    @Override
    @Transactional
    public void addRaceResult(RaceResult raceResult) {
        raceResultDAO.addRaceResult(raceResult);
    }

    @Override
    @Transactional
    public void updateRaceResult(RaceResult raceResult) {
        raceResultDAO.updateRaceResult(raceResult);
    }

    @Override
    @Transactional
    public void deleteRaceResult(RaceResult raceResult) {
        raceResultDAO.deleteRaceResult(raceResult);
    }

    @Override
    @Transactional
    public List<RaceResult> getRaceResultsByRace(Race race) {
        return raceResultDAO.getRaceResultsByRace(race);
    }
    
    @Override
    @Transactional
    public RaceResult getRaceResultsByRaceAndRacer(Race race, Racer racer) {
        return raceResultDAO.getRaceResultsByRaceAndRacer(race,racer);
    }

}
