package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.RacerCarClassCompetitionNumber;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class RacerCarClassCompetitionNumberDAOImpl implements RacerCarClassCompetitionNumberDAO {

	private static final Logger LOG = LoggerFactory.getLogger(RacerCarClassCompetitionNumberDAOImpl.class);
	
    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<RacerCarClassCompetitionNumber> getAllRacerCarClassCompetitionNumbers() {
    	LOG.debug("Get all racerCarClassCompetitionNumbers");
        return entityManager
                .createQuery("from RacerCarClassCompetitionNumber")
                .getResultList();
    }

    @Override
    public RacerCarClassCompetitionNumber getRacerCarClassCompetitionNumberById(int id) {
    	LOG.debug("Get racerCarClassCompetitionNumber with id = {}", id);
        return (RacerCarClassCompetitionNumber) entityManager
                .createQuery("from RacerCarClassCompetitionNumber where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    @Override
    public void addRacerCarClassCompetitionNumber(RacerCarClassCompetitionNumber racerCarClassCompetitionNumber) {
        entityManager.persist(racerCarClassCompetitionNumber);
        LOG.debug("Added racerCarClassCompetititonNumber {}", racerCarClassCompetitionNumber);
    }

    @Override
    public void updateRacerCarClassCompetitionNumber(RacerCarClassCompetitionNumber racerCarClassCompetitionNumber) {
        entityManager.merge(racerCarClassCompetitionNumber);
        LOG.debug("Updated racerCarClassCompetititonNumber with id = {}", racerCarClassCompetitionNumber.getId());
    }

    @Override
    public void deleteRacerCarClassCompetitionNumber(RacerCarClassCompetitionNumber racerCarClassCompetitionNumber) {
        Query query = entityManager.createQuery(
                "DELETE FROM RacerCarClassCompetitionNumber c WHERE c.id = :id");
        query.setParameter("id", racerCarClassCompetitionNumber.getId());
        if (query.executeUpdate() != 0) {
        	LOG.debug("Deleted racerCarClassCompetition number with id = {}", racerCarClassCompetitionNumber.getId());
        } else {
        	LOG.warn("Tried to delete racerCarClassCompetition number with id = {}", racerCarClassCompetitionNumber.getId());
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCarClassCompetitionId(int id) {
        List<RacerCarClassCompetitionNumber> list = null;
        Query query = entityManager.
                createQuery("FROM RacerCarClassCompetitionNumber rcccn "
                        + "WHERE rcccn.carClassCompetition.id = :carClassCompetitionId "
                        + "ORDER BY rcccn.racer.firstName, rcccn.racer.lastName");
        query.setParameter("carClassCompetitionId", id);
        list = query.getResultList();
        LOG.debug("Get racerCarClassCompetitionNumbers by carClassCompetition with id = {}", id);
        return list;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCarClassCompetitionIdAndTeamId(int carClassCompetitionid, int teamId) {
        Query query = entityManager.
                createQuery("FROM RacerCarClassCompetitionNumber rcccn "
                        + "WHERE rcccn.carClassCompetition.id = :carClassCompetitionid AND "
                        + "rcccn.racer.team.id = :teamId "
                        + "ORDER BY rcccn.racer.firstName, rcccn.racer.lastName");
        query.setParameter("carClassCompetitionid", carClassCompetitionid);
        query.setParameter("teamId", teamId);
        LOG.debug("Get racerCarClassCompetitionNumbers by carClassCompetition(id = {}) and team(id = {})", carClassCompetitionid, teamId);
        return query.getResultList();
    }

    @Override
    public int getRacerCarClassCompetitionNumbersCountByCarClassCompetitionId(int id) {
        Query query = entityManager
                .createQuery("SELECT COUNT(*) FROM RacerCarClassCompetitionNumber "
                        + "WHERE car_class_competition_id = :car_class_competition_id");
        query.setParameter("car_class_competition_id", Integer.toString(id));
        Long racersCount = (Long) query.getSingleResult();
        LOG.debug("Get count of racerCarClassCompetitionNumbers by carClassCompetition(id = {}). Count = {}", id, racersCount);
        return racersCount.intValue();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCompetitionId(int id) {
        Query query = entityManager.
                createQuery("FROM RacerCarClassCompetitionNumber rcccn "
                        + "WHERE rcccn.carClassCompetition.competition.id = :id "
                        + "ORDER BY rcccn.racer.team.name, rcccn.racer.firstName, rcccn.racer.lastName");
        query.setParameter("id", id);
        LOG.debug("Get racerCarClassCompetitionNumbers by competition with id = {}", id);
        return query.getResultList();
    }

    @Override
    public void deleteByCarClassCompetitionIdAndRacerId(int carClassCompetitionId, int racerId) {
        Query query = entityManager.
                createQuery("DELETE FROM RacerCarClassCompetitionNumber rcccn "
                        + "WHERE (rcccn.carClassCompetition.id = :carClassCompetitionId) AND "
                        + "(rcccn.racer.id = :racerId)");
        query.setParameter("carClassCompetitionId", carClassCompetitionId);
        query.setParameter("racerId", racerId);
        if (query.executeUpdate() != 0) {
        	LOG.debug("Deleted racerCarClassCompetititonNumber by carClassCompetititon(id = {}) and racer(id = {})", carClassCompetitionId, racerId);
        } else {
        	LOG.warn("Tried to delete racerCarClassCompetititonNumber by carClassCompetititon(id = {}) and racer(id = {})", carClassCompetitionId, racerId);
        }

    }
    

    @SuppressWarnings("unchecked")
    @Override
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCompetitionIdAndTeamId(int competitionId, int teamId) {
        Query query = entityManager.
                createQuery("FROM RacerCarClassCompetitionNumber rcccn "
                        + "WHERE rcccn.carClassCompetition.competition.id = :competitionid AND "
                        + "rcccn.racer.team.id = :teamId");
        query.setParameter("competitionid", competitionId);
        query.setParameter("teamId", teamId);

        LOG.debug("Get racerCarClassCompetitionNumbers by competition(id = {}) and team(id = {})", competitionId, teamId);
        return query.getResultList();
    }

}
