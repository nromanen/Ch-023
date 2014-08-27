package net.carting.service;

import java.sql.Time;
import java.util.List;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.Qualifying;

public interface QualifyingService {

	public List<Qualifying> getAllQualifyings();

	public Qualifying getQualifyingById(int id);

	public void addQualifying(Qualifying qualifying);

	public void updateQualifying(Qualifying qualifying);

	public void deleteQualifying(Qualifying qualifying);

	public List<Qualifying> getQualifyingsByCarClassCompetition(
	            CarClassCompetition carClassCompetition);
	
	public List<Time> getQualifyingTimesByCarClassCompetition(
			CarClassCompetition carClassCompetition);
	
	public List<Integer> getQualifyingNumbersByCarClassCompetition(
			CarClassCompetition carClassCompetition);
	
	public List<Integer> getQualifyingPlacesByCarClassCompetition(
			CarClassCompetition carClassCompetition);
	public boolean setQualifyingTimeFromString(Qualifying q, String time);
	public void setQualifyingPlacesInCarClassCompetition(CarClassCompetition ccc);
}
