package net.carting.service;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import net.carting.dao.QualifyingDAO;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Qualifying;
import net.carting.util.DateUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class QualifyingServiceImpl implements QualifyingService {

    private static final Logger LOG = LoggerFactory
	    .getLogger(QualifyingServiceImpl.class);

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
	return qualifyingDao
		.getQualifyingsByCarClassCompetition(carClassCompetition);
    }

    @Transactional
    @Override
    public List<Integer> getQualifyingTimesByCarClassCompetition(
	    CarClassCompetition carClassCompetition) {
	List<Integer> times = new ArrayList<Integer>();
	List<Qualifying> ques = qualifyingDao
		.getQualifyingsByCarClassCompetition(carClassCompetition);
	for (Qualifying q : ques) {
	    times.add(q.getRacerTime());
	}
	return times;
    }

    @Transactional
    @Override
    public List<Integer> getQualifyingNumbersByCarClassCompetition(
	    CarClassCompetition carClassCompetition) {
	List<Integer> members = new ArrayList<Integer>();
	List<Qualifying> ques = qualifyingDao
		.getQualifyingsByCarClassCompetition(carClassCompetition);
	for (int i = 0; i < ques.size(); i++) {
	    members.add(ques.get(i).getRacerNumber());
	}
	return members;
    }

    @Transactional
    @Override
    public List<Integer> getQualifyingPlacesByCarClassCompetition(
	    CarClassCompetition carClassCompetition) {
	List<Integer> places = new ArrayList<Integer>();
	List<Qualifying> ques = qualifyingDao
		.getQualifyingsByCarClassCompetition(carClassCompetition);
	for (Qualifying q : ques) {
	    places.add(q.getRacerPlace());
	}
	return places;
    }

    @Transactional
    @Override
    public boolean setQualifyingTimeFromString(Qualifying q, String timeString) {
	int timeInt;
	if (!timeString
		.matches("((\\d?\\d:)?[0-5]?\\d:)?[0-5]?\\d(\\.\\d{1,3})?")) {
	    return false;
	}
	try {
	    timeInt = DateUtil.getIntFromTimeString(timeString);
	    q.setRacerTime(timeInt);
	    updateQualifying(q);
	} catch (IllegalArgumentException e) {
	    LOG.error("Errors in setQualifyingTimeFromString method.", e);
	    return false;
	}
	return true;
    }

    @Transactional
    @Override
    public void setQualifyingPlacesInCarClassCompetition(CarClassCompetition ccc) {
	List<Qualifying> qList = getQualifyingsByCarClassCompetition(ccc);
	while (!qList.isEmpty()) {
	    Qualifying q = qList.get(0);
	    for (int j = 1; j < qList.size(); j++) {
    		if (q.getRacerTime() < qList.get(j).getRacerTime()) {
    		    q = qList.get(j);
    		}
	    }
	    q.setRacerPlace(qList.size());
	    updateQualifying(q);
	    qList.remove(q);
	}
    }

    @Transactional
    @Override
    public List<Integer> getRacersNumbersWithSameQTime(CarClassCompetition ccc) {
	List<Qualifying> ques = getQualifyingsByCarClassCompetition(ccc);
	if ((ques == null) || (ques.isEmpty())) {
	    return null;
	}
	List<Integer> qNums = new ArrayList<Integer>();
	for (int i = 0; i < ques.size() - 1; i++) {
		for (int j = i + 1; j < ques.size(); j++) {
		    if (ques.get(i).getRacerTime().equals(ques.get(j)
			    .getRacerTime())) {
		        if (!qNums.contains(ques.get(i).getRacerNumber())) {
        			qNums.add(ques.get(i).getRacerNumber());
		        }
		        if (!qNums.contains(ques.get(j).getRacerNumber())) {
                    qNums.add(ques.get(j).getRacerNumber());
                }
		        
		    }
	    }
	}
	return qNums;
    }
}
