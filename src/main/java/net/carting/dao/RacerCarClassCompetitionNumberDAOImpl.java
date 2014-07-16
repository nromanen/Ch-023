package net.carting.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.carting.domain.RacerCarClassCompetitionNumber;
import net.carting.domain.RacerCarClassNumber;

@Repository
public class RacerCarClassCompetitionNumberDAOImpl implements RacerCarClassCompetitionNumberDAO{
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<RacerCarClassCompetitionNumber> getAllRacerCarClassCompetitionNumbers() {
		return sessionFactory.getCurrentSession().createQuery("from RacerCarClassCompetitionNumber").list();
	}

	@Override
	public RacerCarClassCompetitionNumber getRacerCarClassCompetitionNumberById(int id) {	
		return (RacerCarClassCompetitionNumber) sessionFactory.getCurrentSession().get(RacerCarClassCompetitionNumber.class, id);
	}

	@Override
	public void addRacerCarClassCompetitionNumber(RacerCarClassCompetitionNumber racerCarClassCompetitionNumber) {	
		sessionFactory.getCurrentSession().save(racerCarClassCompetitionNumber);
	}

	@Override
	public void updateRacerCarClassCompetitionNumber(RacerCarClassCompetitionNumber racerCarClassCompetitionNumber) {
		sessionFactory.getCurrentSession().merge(racerCarClassCompetitionNumber);		
	}

	@Override
	public void deleteRacerCarClassCompetitionNumber(RacerCarClassCompetitionNumber racerCarClassCompetitionNumber) {
		sessionFactory.getCurrentSession().delete(racerCarClassCompetitionNumber);
	}
	
	@Override
	public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCarClassCompetitionId(int id) {
		Query query = sessionFactory.getCurrentSession().
					createQuery("FROM RacerCarClassCompetitionNumber rcccn "
								+ "WHERE rcccn.carClassCompetition.id = :carClassCompetitionId "
								+ "ORDER BY rcccn.racer.firstName, rcccn.racer.lastName");
		query.setParameter("carClassCompetitionId", id);
		return query.list();
	}
	
	@Override
	public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCarClassCompetitionIdAndTeamId(int carClassCompetitionid, int teamId) {
		Query query = sessionFactory.getCurrentSession().
					createQuery("FROM RacerCarClassCompetitionNumber rcccn "
								+ "WHERE rcccn.carClassCompetition.id = :carClassCompetitionid AND "
								+ "rcccn.racer.team.id = :teamId "
								+ "ORDER BY rcccn.racer.firstName, rcccn.racer.lastName");
		query.setParameter("carClassCompetitionid", carClassCompetitionid);
		query.setParameter("teamId", teamId);
		return query.list();
	}
		
	@Override
	public int getRacerCarClassCompetitionNumbersCountByCarClassCompetitionId(int id){
		Query query = sessionFactory.getCurrentSession().
				createQuery("SELECT COUNT(*) FROM RacerCarClassCompetitionNumber "
							+ "WHERE car_class_competition_id = :car_class_competition_id");
		query.setParameter("car_class_competition_id", Integer.toString(id));
		return ((Long)query.uniqueResult()).intValue();
	}
	
	@Override
	public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCompetitionId(int id){
		Query query = sessionFactory.getCurrentSession().
				createQuery("FROM RacerCarClassCompetitionNumber rcccn "
						  + "WHERE rcccn.carClassCompetition.competition.id = :id "
						  + "ORDER BY rcccn.racer.team.name, rcccn.racer.firstName, rcccn.racer.lastName");
		query.setParameter("id", id);
		return query.list();
	}
	
	@Override
	public void deleteByCarClassCompetitionIdAndRacerId(int carClassCompetitonId, int racerId){
		Query query = sessionFactory.getCurrentSession().
				createQuery("DELETE FROM RacerCarClassCompetitionNumber rcccn "
							+ "WHERE (rcccn.carClassCompetition.id = :carClassCompetitonId) AND "
							+ "(rcccn.racer.id = :racerId)");
		query.setParameter("carClassCompetitonId", carClassCompetitonId);
		query.setParameter("racerId", racerId);
		query.executeUpdate();
	}
	
	@Override
	public void deleteByCompetitionIdAndRacerId(int competitonId, int racerId){
		Query query = sessionFactory.getCurrentSession().
				createQuery("DELETE FROM RacerCarClassCompetitionNumber rcccn "
							+ "WHERE (rcccn.carClassCompetition.competition.id = :competitonId) AND "
							+ "(rcccn.racer.id = :racerId)");
		query.setParameter("competitonId", competitonId);
		query.setParameter("racerId", racerId);
		query.executeUpdate();
	}
	
	@Override
	public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCompetitionIdAndTeamId(int competitionId, int teamId) {
		Query query = sessionFactory.getCurrentSession().
					createQuery("FROM RacerCarClassCompetitionNumber rcccn "
								+ "WHERE rcccn.carClassCompetition.competition.id = :competitionid AND "
								+ "rcccn.racer.team.id = :teamId");
		query.setParameter("competitionid", competitionId);
		query.setParameter("teamId", teamId);
		return query.list();
	}

}
