package net.carting.service;

import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import net.carting.dao.QualifyingDAO;
import net.carting.dao.QualifyingDAOImpl;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Qualifying;

public class QualifyingServiceImpl implements QualifyingService {

	
	private QualifyingDAO qualifyingDao = new QualifyingDAOImpl();
	
	@Override
	public List<Qualifying> getAllQualifyings() {
		return qualifyingDao.getAllQualifyings();
	}

	@Override
	public Qualifying getQualifyingById(int id) {
		return qualifyingDao.getQualifyingById(id);
	}

	@Override
	public void addQualifying(Qualifying qualifying) {
		qualifyingDao.addQualifying(qualifying);
	}

	@Override
	public void updateQualifying(Qualifying qualifying) {
		qualifyingDao.updateQualifying(qualifying);
	}

	@Override
	public void deleteQualifying(Qualifying qualifying) {
		qualifyingDao.deleteQualifying(qualifying);
	}

	@Override
	public List<Qualifying> getQualifyingsByCarClassCompetition(
			CarClassCompetition carClassCompetition) {
		try {
			return qualifyingDao.getQualifyingsByCarClassCompetition(carClassCompetition);
		} catch (NullPointerException e) {
			System.out.println(e);
			return null;
		}
	}
	
	@Override
	public List<Time> getQualifyingTimesByCarClassCompetition(
			CarClassCompetition carClassCompetition) {
		List<Time> times = new ArrayList<Time>();
		for(Qualifying q:qualifyingDao.getQualifyingsByCarClassCompetition(carClassCompetition)) {
			times.add(q.getRacerTime());
		}
		return times;
	}

	@Override
	public List<Integer> getQualifyingNumbersByCarClassCompetition(
			CarClassCompetition carClassCompetition) {
		List<Integer> members = new ArrayList<Integer>();
		for(Qualifying q:qualifyingDao.getQualifyingsByCarClassCompetition(carClassCompetition)) {
			members.add(q.getRacerNumber());
		}
		return members;
	}

	@Override
	public List<Integer> getQualifyingPlacesByCarClassCompetition(
			CarClassCompetition carClassCompetition) {
		List<Integer> places = new ArrayList<Integer>();
		for(Qualifying q:qualifyingDao.getQualifyingsByCarClassCompetition(carClassCompetition)) {
			places.add(q.getRacerPlace());
		}
		return places;
	}

}
