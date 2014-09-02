package net.carting.service;

import java.sql.Time;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

import javax.transaction.Transactional;

import net.carting.dao.QualifyingDAO;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Qualifying;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class QualifyingServiceImpl implements QualifyingService {

    private static final Logger LOG = LoggerFactory.getLogger(QualifyingServiceImpl.class);
    
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
		return qualifyingDao.getQualifyingsByCarClassCompetition(carClassCompetition);
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
	
	@Transactional
	@Override
	public boolean setQualifyingTimeFromString(Qualifying q, String time) {
		TimeZone.setDefault(TimeZone.getTimeZone("GMT-00:00"));
		long timeLong = 0;
		time = time.trim();
		if (!time.matches("((\\d{1,2}:)?[0-5]?\\d:)?[0-5]?\\d(\\.\\d{1,3})?")) {
			return false;	
		}
		try {
			timeLong = timeStringToLong(time);
			q.setRacerTime(new Time(timeLong));
			updateQualifying(q);
		} catch (IllegalArgumentException e) {
			LOG.error("Errors in setQualifyingTimeFromString method.", e);
			return false;
		}
		return true;
	}
	/**This method convert strings to long for sql.Time
	 * In switch-case we choose representation of time - have we hours,minutes or seconds
	 * @param strTime - String data type of time
	 * @return time in milliseconds
	 */
	 public static long timeStringToLong(String strTime) {
	        String[]str = strTime.split(":");
	        long t = 0;
	        switch(str.length) {
	        case 1:
	           t=getMsFromS(str[0]);
	           break;
	        case 2:
	            t=Long.parseLong(str[0])*1000*60;
	            t=t+getMsFromS(str[1]);
	            break;
	        case 3:
	            t=Long.parseLong(str[0])*1000*3600;
	            t=t+Long.parseLong(str[1])*1000*60;
	            t=t+getMsFromS(str[2]);
	            break;
	        }
	        return t;
	    }
	 /**In this method we taking millisecond part
	  * If there is not ms we return only seconds
	  * @param s - seconds with milliseconds
	  * @return milliseconds
	  */
	    public static long getMsFromS(String s) {
	        long t= 0;
	        String[] milisecs=s.split("\\.");
	        if (milisecs.length==1) {
	        	return Long.parseLong(milisecs[0])*1000;
	        }
	        if (milisecs[1].length()==3){
	            t=t+Long.parseLong(milisecs[1]);
	        } else if (milisecs[1].length()==2) {
	            t=t+(Long.parseLong(milisecs[1])*10);
	        } else if (milisecs[1].length()==1) {
	            t=t+(Long.parseLong(milisecs[1])*100);
	        }
	        t=t+(Long.parseLong(milisecs[0])*1000);
	        return t;
	    }
	
	@Transactional
	@Override
	public void setQualifyingPlacesInCarClassCompetition(CarClassCompetition ccc) {
		List <Qualifying> qList = getQualifyingsByCarClassCompetition(ccc);
		while (qList.size()>0) {
			Qualifying q = qList.get(0);
				for (int j=1;j<qList.size();j++) {
					if(q.getRacerTime().toString().compareTo(qList.get(j).getRacerTime().toString())<0) {
						q=qList.get(j);
					}
				}
				q.setRacerPlace(qList.size());
				updateQualifying(q);
				qList.remove(q);
			}
		}
}
