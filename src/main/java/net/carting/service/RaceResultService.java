package net.carting.service;

import net.carting.domain.Race;
import net.carting.domain.RaceResult;
import net.carting.domain.Racer;

import java.util.List;

public interface RaceResultService {

    public List<RaceResult> getAllRaceResults();

    public RaceResult getRaceResultById(int id);

    public void addRaceResult(RaceResult raceResult);

    public void updateRaceResult(RaceResult raceResult);

    public void deleteRaceResult(RaceResult raceResult);

    public List<RaceResult> getRaceResultsByRace(Race race);
    
    public RaceResult getRaceResultsByRaceAndRacer(Race race, Racer racer);

}
