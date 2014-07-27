package net.carting.dao;

import java.util.List;

import javax.persistence.*;

import org.springframework.stereotype.Repository;

import net.carting.domain.RacerCarClassCompetitionNumber;

@Repository
public class RacerCarClassCompetitionNumberDAOImpl implements RacerCarClassCompetitionNumberDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public List<RacerCarClassCompetitionNumber> getAllRacerCarClassCompetitionNumbers() {
        List<RacerCarClassCompetitionNumber> competitionNumbers = entityManager
                .createQuery("from RacerCarClassCompetitionNumber")
                .getResultList();
        
        return competitionNumbers;
    }

    @Override
    public RacerCarClassCompetitionNumber getRacerCarClassCompetitionNumberById(int id) {
        RacerCarClassCompetitionNumber number = (RacerCarClassCompetitionNumber) entityManager
                .createQuery("from RacerCarClassCompetitionNumber where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);
        
        return number;
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
        entityManager.remove(racerCarClassCompetitionNumber);
        
    }

    @Override
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCarClassCompetitionId(int id) {
        Query query = entityManager.
                createQuery("FROM RacerCarClassCompetitionNumber rcccn "
                        + "WHERE rcccn.carClassCompetition.id = :carClassCompetitionId "
                        + "ORDER BY rcccn.racer.firstName, rcccn.racer.lastName");
        query.setParameter("carClassCompetitionId", id);
        List<RacerCarClassCompetitionNumber> competitionNumbers = query.getResultList();
        
        return competitionNumbers;
    }

    @Override
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCarClassCompetitionIdAndTeamId(int carClassCompetitionid, int teamId) {
        Query query = entityManager.
                createQuery("FROM RacerCarClassCompetitionNumber rcccn "
                        + "WHERE rcccn.carClassCompetition.id = :carClassCompetitionid AND "
                        + "rcccn.racer.team.id = :teamId "
                        + "ORDER BY rcccn.racer.firstName, rcccn.racer.lastName");
        query.setParameter("carClassCompetitionid", carClassCompetitionid);
        query.setParameter("teamId", teamId);
        List<RacerCarClassCompetitionNumber> competitionNumbers = query.getResultList();
        
        return competitionNumbers;
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

    @Override
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCompetitionId(int id) {
        Query query = entityManager.
                createQuery("FROM RacerCarClassCompetitionNumber rcccn "
                        + "WHERE rcccn.carClassCompetition.competition.id = :id "
                        + "ORDER BY rcccn.racer.team.name, rcccn.racer.firstName, rcccn.racer.lastName");
        query.setParameter("id", id);
        List<RacerCarClassCompetitionNumber> competitionNumbers = query.getResultList();
        
        return competitionNumbers;
    }

    @Override
    public void deleteByCarClassCompetitionIdAndRacerId(int carClassCompetitonId, int racerId) {
        Query query = entityManager.
                createQuery("DELETE FROM RacerCarClassCompetitionNumber rcccn "
                        + "WHERE (rcccn.carClassCompetition.id = :carClassCompetitonId) AND "
                        + "(rcccn.racer.id = :racerId)");
        query.setParameter("carClassCompetitonId", carClassCompetitonId);
        query.setParameter("racerId", racerId);
        query.executeUpdate();
        
    }

    @Override
    public void deleteByCompetitionIdAndRacerId(int competitonId, int racerId) {
        Query query = entityManager.
                createQuery("DELETE FROM RacerCarClassCompetitionNumber rcccn "
                        + "WHERE (rcccn.carClassCompetition.competition.id = :competitonId) AND "
                        + "(rcccn.racer.id = :racerId)");
        query.setParameter("competitonId", competitonId);
        query.setParameter("racerId", racerId);
        query.executeUpdate();
        
    }

    @Override
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCompetitionIdAndTeamId(int competitionId, int teamId) {
        Query query = entityManager.
                createQuery("FROM RacerCarClassCompetitionNumber rcccn "
                        + "WHERE rcccn.carClassCompetition.competition.id = :competitionid AND "
                        + "rcccn.racer.team.id = :teamId");
        query.setParameter("competitionid", competitionId);
        query.setParameter("teamId", teamId);
        List<RacerCarClassCompetitionNumber> competitionNumbers = query.getResultList();
        
        return competitionNumbers;
    }

}
