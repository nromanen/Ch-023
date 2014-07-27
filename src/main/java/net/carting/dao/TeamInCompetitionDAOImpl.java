package net.carting.dao;

import net.carting.domain.TeamInCompetition;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TeamInCompetitionDAOImpl implements TeamInCompetitionDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

	@Override
	public boolean isTeamInCompetition(int teamId, int competitonId) {
		String sql = "SELECT id FROM team_in_competition WHERE team_id = :team_id AND competition_id = :competition_id";
		Query query = entityManager.createQuery(sql)
				.setParameter("team_id", teamId)
				.setParameter("competition_id", competitonId);

		List result = query.getResultList();

        
        return result.size() > 0;
    }

	@Override
	public void addTeamInCompetition(TeamInCompetition teamInCompetition) {
        entityManager.persist(teamInCompetition);
        
	}

	@Override
	public void deleteTeamInCompetition(TeamInCompetition teamInCompetition) {
        entityManager.remove(teamInCompetition);
        
	}

	@Override
	public List<TeamInCompetition> getTeamInCompetitionListByTeamId(int teamId){
		Query query = entityManager.
				createQuery("FROM TeamInCompetition "
							+ "WHERE team.id = :teamId "
							+ "ORDER BY competition.dateStart");
		query.setParameter("teamId", teamId);
        List<TeamInCompetition> teams = query.getResultList();
        
		return teams;
	}

	@Override
	public void deleteTeamInCompetitionByTeamIdAndCompetitionId(int teamId, int competitionId){
		Query query = entityManager.
				createQuery("DELETE FROM TeamInCompetition "
							+ "WHERE (team.id = :teamId) AND "
							+ "(competition.id = :competitionId)");
		query.setParameter("teamId", teamId);
		query.setParameter("competitionId", competitionId);
		query.executeUpdate();
        
	}
}
