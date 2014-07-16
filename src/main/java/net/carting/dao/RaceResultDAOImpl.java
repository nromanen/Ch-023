package net.carting.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.carting.domain.Race;
import net.carting.domain.RaceResult;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassNumber;

@Repository
public class RaceResultDAOImpl implements RaceResultDAO {
	
	@Autowired
	  private SessionFactory sessionFactory;

	@Override
	public List<RaceResult> getAllRaceResults() {
		return sessionFactory.getCurrentSession().createQuery("from RaceResult").list();
	}

	@Override
	public RaceResult getRaceResultById(int id) {
		return (RaceResult) sessionFactory.getCurrentSession().get(RaceResult.class, id);
	}

	@Override
	public void addRaceResult(RaceResult raceResult) {
		 sessionFactory.getCurrentSession().save(raceResult);
		
	}

	@Override
	public void updateRaceResult(RaceResult raceResult) {
		sessionFactory.getCurrentSession().merge(raceResult);
		
	}

	@Override
	public void deleteRaceResult(RaceResult raceResult) {
		 sessionFactory.getCurrentSession().delete(raceResult);
		
	}

	@Override
	public List<RaceResult> getRaceResultsByRace(Race race) {
		Query query = sessionFactory.getCurrentSession().createQuery("from RaceResult where race= :race order by place ").setParameter("race",race);
		return (ArrayList<RaceResult>) query.list();
	}

	@Override
	public RaceResult getRaceResultByRaceNumberAndRacer(int raceNumber,Racer racer) {
		
		Query query = sessionFactory.getCurrentSession().
				createQuery("FROM RaceResult rr "
							+ "WHERE rr.race.raceNumber  = :raceNumber AND racer=:racer");
		query.setParameter("raceNumber", raceNumber);
		query.setParameter("racer", racer);
		
		return (RaceResult) (query.list().get(0));
	}

}
