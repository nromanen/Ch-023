package net.carting.dao;

import java.text.SimpleDateFormat;
import java.util.List;

import net.carting.domain.CarClassCompetition;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CarClassCompetitionDAOImpl implements CarClassCompetitionDAO{
	
	@Autowired
	private SessionFactory sessionFactory;
	
	SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm");

	@Override
	public List<CarClassCompetition> getAllCarClassCompetitions() {
		return sessionFactory.getCurrentSession().createQuery("from CarClassCompetition").list();
	}

	@Override
	public CarClassCompetition getCarClassCompetitionById(int id) {
		return (CarClassCompetition) sessionFactory.getCurrentSession().get(CarClassCompetition.class, id);
	}

	@Override
	public void addCarClassCompetition(CarClassCompetition carClassCompetition) {
		sessionFactory.getCurrentSession().save(carClassCompetition);		
	}

	@Override
	public void updateCarClassCompetition(CarClassCompetition carClassCompetition) {

		Query query = sessionFactory.getCurrentSession().createQuery("UPDATE CarClassCompetition "
				+ "SET firstRaceTime = :firstRaceTime, "
				+ "secondRaceTime = :secondRaceTime, "
				+ "circleCount = :circleCount, "
				+ "percentageOffset = :percentageOffset "
				+ "WHERE id = :id");
		
		query.setTime("firstRaceTime", carClassCompetition.getFirstRaceTime());
		query.setTime("secondRaceTime", carClassCompetition.getSecondRaceTime());
		query.setParameter("circleCount", carClassCompetition.getCircleCount());
		query.setParameter("percentageOffset", carClassCompetition.getPercentageOffset());
		query.setParameter("id", carClassCompetition.getId());
		
		query.executeUpdate();
	}

	@Override
	public void deleteCarClassCompetition(CarClassCompetition carClassCompetition) {
		sessionFactory.getCurrentSession().delete(carClassCompetition);		
	}
	
	@Override
	public List<CarClassCompetition> getCarClassCompetitionsByCompetitionId(int competitonId) {	
		Query query = sessionFactory.getCurrentSession().
				createQuery("FROM CarClassCompetition ccc "
						  + "WHERE ccc.competition.id = :id "
						  + "ORDER BY ccc.carClass.name");
		query.setParameter("id", competitonId);
		return query.list();
	}
	
	@Override
	public List<CarClassCompetition> getCarClassCompetitionsByCarClassId(int carClassId) {	
		Query query = sessionFactory.getCurrentSession().
				createQuery("FROM CarClassCompetition ccc "
						  + "WHERE ccc.carClass.id = :id "
						  + "ORDER BY ccc.carClass.name");
		query.setParameter("id", carClassId);
		return query.list();
	}
	

}
