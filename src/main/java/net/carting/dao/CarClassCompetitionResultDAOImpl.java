package net.carting.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.CarClassCompetitionResult;

@Repository
public class CarClassCompetitionResultDAOImpl implements CarClassCompetitionResultDAO{
	
	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public List<CarClassCompetitionResult> getAllCarClassCompetitionResults() {
		return sessionFactory.getCurrentSession().createQuery("from CarClassCompetitionResult") .list();
	}

	@Override
	public CarClassCompetitionResult getCarClassCompetitionResultById(int id) {
		return (CarClassCompetitionResult) sessionFactory.getCurrentSession().get(CarClassCompetitionResult.class, id);
	}

	@Override
	public void addCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult) {
		sessionFactory.getCurrentSession().save(carClassCompetitionResult);
		
	}

	@Override
	public void updateCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult) {
		sessionFactory.getCurrentSession().merge(carClassCompetitionResult);		
	}

	@Override
	public void deleteCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult) {
		sessionFactory.getCurrentSession().delete(carClassCompetitionResult);	
	}

	@Override
	public List<CarClassCompetitionResult> getCarClassCompetitionResultsByCarClassCompetition(
			CarClassCompetition carClassCompetition) {
		
			Query query = sessionFactory.getCurrentSession().createQuery("from CarClassCompetitionResult cccr where cccr.racerCarClassCompetitionNumber.carClassCompetition = :carClassCompetition order by absolutePlace").setParameter("carClassCompetition",carClassCompetition);
			return query.list();
			
	}

	@Override
	public List<CarClassCompetitionResult> getCarClassCompetitionResultsOrderedByPoints(
			CarClassCompetition carClassCompetition) {
		Query query = sessionFactory.getCurrentSession().createQuery("from CarClassCompetitionResult cccr where cccr.racerCarClassCompetitionNumber.carClassCompetition = :carClassCompetition order by absolutePoints desc").setParameter("carClassCompetition",carClassCompetition);
		return query.list();
	}

}

