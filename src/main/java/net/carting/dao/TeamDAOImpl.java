package net.carting.dao;

import net.carting.domain.Leader;
import net.carting.domain.Team;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class TeamDAOImpl implements TeamDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	@Override
	public List<Team> getAllTeams() {
		return sessionFactory.getCurrentSession().createQuery("FROM Team").list();
	}

	@Override
	public Team getTeamById(int id) {
		return (Team) sessionFactory.getCurrentSession().get(Team.class, id);
	}

	public void addTeam(Team team) {
		sessionFactory.getCurrentSession().save(team);
	}

	@Override
	public void updateTeam(Team team) {
		sessionFactory.getCurrentSession().merge(team);
	}

	@Override
	public void deleteTeam(Team team) {
		sessionFactory.getCurrentSession().delete(team);

	}

	@Override
	public boolean isSetTeam(String teamName) {
		String hql = "FROM Team WHERE name = ?";
		Query query = sessionFactory.getCurrentSession().createQuery(hql).setString(0, teamName);

		Team result = (Team) query.uniqueResult();
		if (result != null) {
			return true;
		}
		return false;
	}

	@Override
	public Team getTeamByLeader(Leader leader) {
		Query query = sessionFactory.getCurrentSession()
				.createQuery("FROM Team WHERE leader = :leader")
				.setParameter("leader", leader);
		return (Team) query.uniqueResult();
	}

	@Override
	public boolean isTeamByLeaderId(int leaderId) {
		Query query = sessionFactory.getCurrentSession().createQuery("FROM Team WHERE leader.id = :leaderId");
		query.setInteger("leaderId", leaderId);
		
		Team result = (Team) query.uniqueResult();
		if (result != null) {
			return true;
		}
		return false;
	}
	

}
