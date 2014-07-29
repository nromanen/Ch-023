package net.carting.dao;

import net.carting.domain.RacerCarClassCompetitionNumber;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class RacerCarClassCompetitionNumberDAOImpl implements RacerCarClassCompetitionNumberDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<RacerCarClassCompetitionNumber> getAllRacerCarClassCompetitionNumbers() {
        return entityManager
                .createQuery("from RacerCarClassCompetitionNumber")
                .getResultList();
    }

    @Override
    public RacerCarClassCompetitionNumber getRacerCarClassCompetitionNumberById(int id) {
        return (RacerCarClassCompetitionNumber) entityManager
                .createQuery("from RacerCarClassCompetitionNumber where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);
    }

    @Override
    public void addRacerCarClassCompetitionNumber(RacerCarClassCompetitionNumber racerCarClassCompetitionNumber) {
        entityManager.persist(racerCarClassCompetitionNumber);
    }

    @Override
    public void updateRacerCarClassCompetitionNumber(RacerCarClassCompetitionNumber racerCarClassCompetitionNumber) {
        entityManager.merge(racerCarClassCompetitionNumber);
    }

    @Override
    public void deleteRacerCarClassCompetitionNumber(RacerCarClassCompetitionNumber racerCarClassCompetitionNumber) {
        Query query = entityManager.createQuery(
                "DELETE FROM RacerCarClassCompetitionNumber c WHERE c.id = :id");
        query.setParameter("id", racerCarClassCompetitionNumber.getId());
        query.executeUpdate();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCarClassCompetitionId(int id) {
        Query query = entityManager.
                createQuery("FROM RacerCarClassCompetitionNumber rcccn "
                        + "WHERE rcccn.carClassCompetition.id = :carClassCompetitionId "
                        + "ORDER BY rcccn.racer.firstName, rcccn.racer.lastName");
        query.setParameter("carClassCompetitionId", id);

        return query.getResultList();
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

        return query.getResultList();
    }

    @Override
    public int getRacerCarClassCompetitionNumbersCountByCarClassCompetitionId(int id) {
        Query query = entityManager
                .createQuery("SELECT COUNT(*) FROM RacerCarClassCompetitionNumber "
                        + "WHERE car_class_competition_id = :car_class_competition_id");
        query.setParameter("car_class_competition_id", Integer.toString(id));
        Long racersCount = (Long) query.getSingleResult();
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
        query.executeUpdate();

    }

    @Override
    public void deleteByCompetitionIdAndRacerId(int competitionId, int racerId) {
        Query query = entityManager.
                createQuery("DELETE FROM RacerCarClassCompetitionNumber rcccn "
                        + "WHERE (rcccn.carClassCompetition.competition.id = :competitionId) AND "
                        + "(rcccn.racer.id = :racerId)");
        query.setParameter("competitionId", competitionId);
        query.setParameter("racerId", racerId);
        query.executeUpdate();

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

        return query.getResultList();
    }

}
