package net.carting.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.carting.domain.Competition;

@Repository
public class CompetitionDAOImpl implements CompetitionDAO{
	
	public static final int COMPETITION_PER_PAGE = 1;
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<Competition> getAllCompetitions() {
		Query query = sessionFactory.getCurrentSession().createQuery("from Competition ORDER BY dateStart DESC");
		return query.list();
	}
	
	@Override
	public List<Competition> getCompetitionsByYear(int year) {
		Query query = sessionFactory.getCurrentSession()
				.createQuery("from Competition WHERE YEAR(dateStart) = :year ORDER BY dateStart DESC");
		query.setInteger("year", year);
		return query.list();
	}
	
	@Override
	public List<Competition> getAllCompetitionsByPage(int page) {
		Query query = sessionFactory.getCurrentSession()
				.createQuery("from Competition ORDER BY dateStart DESC");
		query.setFirstResult((page - 1) * COMPETITION_PER_PAGE);
		query.setMaxResults(COMPETITION_PER_PAGE);
		return (List<Competition>) query.list();
	}

	@Override
	public Competition getCompetitionById(int id) {
		return (Competition) sessionFactory.getCurrentSession().get(Competition.class, id);
	}

	@Override
	public void addCompetition(Competition competition) {
		sessionFactory.getCurrentSession().save(competition);		
	}

	@Override
	public void updateCompetition(Competition competition) {
		sessionFactory.getCurrentSession().merge(competition);		
	}

	@Override
	public void deleteCompetition(Competition competition) {
		sessionFactory.getCurrentSession().delete(competition);		
	}
	
	@Override
	public void setEnabled(int competitionId, boolean enabled){		
		Query query = sessionFactory.getCurrentSession().
				createQuery("UPDATE Competition SET enabled = :enabled "
							+ "WHERE id = :id");
		query.setBoolean("enabled", enabled);
		query.setInteger("id", competitionId);
		query.executeUpdate();	
	}
	
	@Override
	public List<Integer> getCompetitionsYearsList(){
		Query query = sessionFactory.getCurrentSession()
				.createQuery("SELECT YEAR(dateStart) FROM Competition "
						+ "GROUP BY YEAR(dateStart) "
						+ "ORDER BY YEAR(dateStart) DESC");
		return (List<Integer>) query.list();
	}

}
