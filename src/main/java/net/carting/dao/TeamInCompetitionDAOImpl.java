package net.carting.dao;

import net.carting.domain.TeamInCompetition;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class TeamInCompetitionDAOImpl implements TeamInCompetitionDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public boolean isTeamInCompetition(int teamId, int competitionId) {
        String sql = "SELECT id FROM team_in_competition WHERE team_id = :team_id AND competition_id = :competition_id";
        Query query = entityManager.createQuery(sql)
                .setParameter("team_id", teamId)
                .setParameter("competition_id", competitionId);
        List result = query.getResultList();
        return result.size() > 0;
    }

    @Override
    public void addTeamInCompetition(TeamInCompetition teamInCompetition) {
        entityManager.persist(teamInCompetition);
    }

    @Override
    public void deleteTeamInCompetition(TeamInCompetition teamInCompetition) {
        Query query = entityManager.createQuery(
                "DELETE FROM TeamInCompetition c WHERE c.id = :id");
        query.setParameter("id", teamInCompetition.getId());
        query.executeUpdate();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<TeamInCompetition> getTeamInCompetitionListByTeamId(int teamId) {
        Query query = entityManager.
                createQuery("FROM TeamInCompetition "
                        + "WHERE team.id = :teamId "
                        + "ORDER BY competition.dateStart");
        query.setParameter("teamId", teamId);
        return query.getResultList();
    }

    @Override
    public void deleteTeamInCompetitionByTeamIdAndCompetitionId(int teamId, int competitionId) {
        Query query = entityManager.
                createQuery("DELETE FROM TeamInCompetition "
                        + "WHERE (team.id = :teamId) AND "
                        + "(competition.id = :competitionId)");
        query.setParameter("teamId", teamId);
        query.setParameter("competitionId", competitionId);
        query.executeUpdate();
    }

}
