package net.carting.dao;

import java.util.List;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.Race;

public interface RaceDAO {
	
		public List<Race> getAllRaces();

	    public Race getRaceById(int id);

	    public void addRace(Race race);

	    public void updateRace(Race race);

	    public void deleteRace(Race race);

		public List<Race> getRacesByCarClassCompetition(
				CarClassCompetition carClassCompetition);
		
		public Race getRaceByNumberAndCarClassCompetition(int raceNumber, CarClassCompetition carClassCompetition);

}
