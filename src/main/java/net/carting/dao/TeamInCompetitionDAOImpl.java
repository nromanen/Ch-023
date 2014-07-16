package net.carting.dao;

import net.carting.domain.TeamInCompetition;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TeamInCompetitionDAOImpl implements TeamInCompetitionDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public boolean isTeamInCompetition(int teamId, int competitonId) {
		String sql = "SELECT id FROM team_in_competition WHERE team_id = :team_id AND competition_id = :competition_id";
		Query query = sessionFactory.getCurrentSession().createSQLQuery(sql)
				.setParameter("team_id", teamId)
				.setParameter("competition_id", competitonId);

		List result = query.list();
		if (result.size() > 0) {
			return true;
		}
		return false;
	}

	@Override
	public void addTeamInCompetition(TeamInCompetition teamInCompetition) {
		sessionFactory.getCurrentSession().save(teamInCompetition);
	}

	@Override
	public void deleteTeamInCompetition(TeamInCompetition teamInCompetition) {
		sessionFactory.getCurrentSession().delete(teamInCompetition);
	}
	
	@Override
	public List<TeamInCompetition> getTeamInCompetitionListByTeamId(int teamId){
		Query query = sessionFactory.getCurrentSession().
				createQuery("FROM TeamInCompetition "
							+ "WHERE team.id = :teamId "
							+ "ORDER BY competition.dateStart");
		query.setParameter("teamId", teamId);
		return query.list();
	}

	@Override
	public void deleteTeamInCompetitionByTeamIdAndCompetitionId(int teamId, int competitionId){
		Query query = sessionFactory.getCurrentSession().
				createQuery("DELETE FROM TeamInCompetition "
							+ "WHERE (team.id = :teamId) AND "
							+ "(competition.id = :competitionId)");
		query.setParameter("teamId", teamId);
		query.setParameter("competitionId", competitionId);
		query.executeUpdate();
	}
}
