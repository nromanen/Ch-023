package net.carting.dao;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.TeamInCompetition;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class TeamInCompetitionDAOImpl implements TeamInCompetitionDAO {

    private static final Logger LOG = LoggerFactory.getLogger(TeamInCompetitionDAOImpl.class);

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public boolean isTeamInCompetition(int teamId, int competitionId) {
        String sql = "SELECT id FROM team_in_competition WHERE team_id = :team_id AND competition_id = :competition_id";
        Query query = entityManager.createNativeQuery(sql)
                .setParameter("team_id", teamId)
                .setParameter("competition_id", competitionId);
        List result = query.getResultList();
        LOG.debug("Teamd(id = {}) is {} in competition(id = {})", teamId, (result.size() > 0 ? "" : "not"), competitionId);
        return result.size() > 0;
    }

    @Override
    public void addTeamInCompetition(TeamInCompetition teamInCompetition) {
        entityManager.persist(teamInCompetition);
        LOG.debug("Added teamInCompetition {}", teamInCompetition);
    }

    @Override
    public void deleteTeamInCompetition(TeamInCompetition teamInCompetition) {
        Query query = entityManager.createQuery(
                "DELETE FROM TeamInCompetition c WHERE c.id = :id");
        query.setParameter("id", teamInCompetition.getId());
        if (query.executeUpdate() != 0) {
            LOG.debug("Deleted teamInCompetition with id = {}", teamInCompetition.getId());
        } else {
            LOG.warn("Tried to delete teamInCompetition with id = {}", teamInCompetition.getId());
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<TeamInCompetition> getTeamInCompetitionListByTeamId(int teamId) {
        Query query = entityManager.
                createQuery("FROM TeamInCompetition "
                        + "WHERE team.id = :teamId "
                        + "ORDER BY competition.dateStart");
        query.setParameter("teamId", teamId);
        LOG.debug("Get teamInCompetition list by team with id = {}", teamId);
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<TeamInCompetition> getTeamInCompetitionListByTeamIdForCurrentYear(int teamId) {
        Query query = entityManager.
                createQuery("FROM TeamInCompetition "
                        + "WHERE team.id = :teamId AND YEAR(competition.dateEnd) >= :currentYear "
                        + "ORDER BY competition.dateStart");
        query.setParameter("teamId", teamId);
        query.setParameter("currentYear", new GregorianCalendar().getInstance().get(Calendar.YEAR));
        LOG.debug("Get teamInCompetition list by team with id = {}", teamId);
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
        if (query.executeUpdate() != 0) {
            LOG.debug("Deleted teamInCompetition by teamId({}) and competitionId({})", teamId, competitionId);
        } else {
            LOG.warn("Tried to delete teamInCompetition by teamId({}) and competitionId({})", teamId, competitionId);
        }
    }

}
