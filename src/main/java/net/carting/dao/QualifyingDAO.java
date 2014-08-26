package net.carting.dao;

import java.util.List;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.Qualifying;

public interface QualifyingDAO {
	 
	public List<Qualifying> getAllQualifyings();

	public Qualifying getQualifyingById(int id);

	public void addQualifying(Qualifying qualifying);

	public void updateQualifying(Qualifying qualifying);

	public void deleteQualifying(Qualifying qualifying);

	public List<Qualifying> getQualifyingsByCarClassCompetition(
	            CarClassCompetition carClassCompetition);
	
}
