package net.carting.dao;

import net.carting.domain.Leader;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LeaderDAOImpl implements LeaderDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<Leader> getAllLeaders() {
		return sessionFactory.getCurrentSession()
				.createQuery("from Leader ORDER BY registrationDate DESC, lastName, firstName").list();
	}

	@Override
	public Leader getLeaderById(int id) {
		return (Leader) sessionFactory.getCurrentSession().get(Leader.class, id);
	}

	public void addLeader(Leader leader) {
		sessionFactory.getCurrentSession().save(leader);
	}

	@Override
	public void updateLeader(Leader leader) {
		sessionFactory.getCurrentSession().merge(leader);
	}

	@Override
	public void deleteLeader(Leader leader) {
		sessionFactory.getCurrentSession().delete(leader);
	}

	@Override
	public Leader getLeaderByUserName(String username) {
		Query query = sessionFactory.getCurrentSession().
				createQuery("FROM Leader WHERE user.username = :username");
		query.setParameter("username", username);
		return (Leader) query.uniqueResult();
	}

}
