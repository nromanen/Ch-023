package net.carting.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.Race;
import net.carting.domain.RaceResult;

@Repository
public class RaceDAOImpl implements RaceDAO{
	

    @Autowired
    private SessionFactory sessionFactory;

	@Override
	public List<Race> getAllRaces() {		
		return sessionFactory.getCurrentSession().createQuery("from Race").list();
	}

	@Override
	public Race getRaceById(int id) {
		
		return (Race) sessionFactory.getCurrentSession().get(Race.class, id);
	}

	@Override
	public void addRace(Race race) {
		sessionFactory.getCurrentSession().save(race);
		
	}

	@Override
	public void updateRace(Race race) {
		sessionFactory.getCurrentSession().merge(race);
		
	}

	@Override
	public void deleteRace(Race race) {
		sessionFactory.getCurrentSession().delete(race);
		
	}

	@Override
	public List<Race> getRacesByCarClassCompetition(
			CarClassCompetition carClassCompetition) {
		Query query = sessionFactory.getCurrentSession().createQuery("from Race where carClassCompetition = :carClassCompetition order by raceNumber").setParameter("carClassCompetition",carClassCompetition);
		return query.list();
	}

	@Override
	public Race getRaceByNumberAndCarClassCompetition(int raceNumber, CarClassCompetition carClassCompetition) {

		Query query = sessionFactory.getCurrentSession().
				createQuery(" FROM Race WHERE (carClassCompetition= :carClassCompetition) AND "
							+ "(raceNumber = :raceNumber)");
		query.setParameter("carClassCompetition", carClassCompetition);
		query.setParameter("raceNumber", raceNumber);
		return (Race) query.uniqueResult();
	}
	
	

	

}
