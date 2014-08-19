package net.carting.service;

import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.carting.dao.QualifyingDAO;
import net.carting.dao.QualifyingDAOImpl;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Qualifying;
@Service
public class QualifyingServiceImpl implements QualifyingService {

	@Autowired
	private QualifyingDAO qualifyingDao;

	@Transactional
	@Override
	public List<Qualifying> getAllQualifyings() {
		return qualifyingDao.getAllQualifyings();
	}

	@Transactional
	@Override
	public Qualifying getQualifyingById(int id) {
		return qualifyingDao.getQualifyingById(id);
	}

	@Transactional
	@Override
	public void addQualifying(Qualifying qualifying) {
		qualifyingDao.addQualifying(qualifying);
	}

	@Transactional
	@Override
	public void updateQualifying(Qualifying qualifying) {
		qualifyingDao.updateQualifying(qualifying);
	}

	@Transactional
	@Override
	public void deleteQualifying(Qualifying qualifying) {
		qualifyingDao.deleteQualifying(qualifying);
	}

	@Transactional
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
	
	@Transactional
	@Override
	public List<Time> getQualifyingTimesByCarClassCompetition(
			CarClassCompetition carClassCompetition) {
		List<Time> times = new ArrayList<Time>();
		List<Qualifying> ques = qualifyingDao.getQualifyingsByCarClassCompetition(carClassCompetition);
		for(Qualifying q:ques) {
			times.add(q.getRacerTime());
		}
		return times;
	}

	@Transactional
	@Override
	public List<Integer> getQualifyingNumbersByCarClassCompetition(
			CarClassCompetition carClassCompetition) {
		List<Integer> members = new ArrayList<Integer>();
		List<Qualifying> ques = qualifyingDao.getQualifyingsByCarClassCompetition(carClassCompetition);
		for(int i=0; i<ques.size();i++) {
			members.add(ques.get(i).getRacerNumber());
		}
		return members;
	}

	@Transactional
	@Override
	public List<Integer> getQualifyingPlacesByCarClassCompetition(
			CarClassCompetition carClassCompetition) {
		List<Integer> places = new ArrayList<Integer>();
		List<Qualifying> ques = qualifyingDao.getQualifyingsByCarClassCompetition(carClassCompetition);
		for(Qualifying q:ques) {
			places.add(q.getRacerPlace());
		}
		return places;
	}

}
