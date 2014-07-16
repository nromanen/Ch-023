package net.carting.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import net.carting.domain.CarClass;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Race;
import net.carting.domain.RaceResult;

public interface RaceService {
	
	public List<Race> getAllRaces();

    public Race getRaceById(int id);

    public void addRace(Race race);

    public void updateRace(Race race);

    public void deleteRace(Race race);
    
    public List<Set<Integer>> getChessRoll(Race race);
  
    public void setResultTable(List<Set<Integer>> circles, Race race);
    
    public List<RaceResult> getResultTable(Race race);

    public List<Integer> getNumbersArrayByCarClass(CarClass carClass);
    
    public List<Integer> getNumbersArrayByCarClassCompetitionId(Integer carClassCompetitionId);
    
    public List<Race> getRacesByCarClassCompetition(CarClassCompetition carClassCompetition);
    
    public List<List<RaceResult>> getRaceResultsByCarClassCompetition(CarClassCompetition carClassCompetition); 
   
    public List<List<Set<Integer>>> getChessRollsByCarClassCompetition(CarClassCompetition carClassCompetition);
    
    public void setRaceNumber(CarClassCompetition carClassCompetition, Race race);
    
    public Race getRaceByNumberAndCarClassCompetition(int raceNumber, CarClassCompetition carClassCompetition);
}
