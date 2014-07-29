package net.carting.dao;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.Race;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class RaceDAOImpl implements RaceDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<Race> getAllRaces() {
        return entityManager
                .createQuery("from Race")
                .getResultList();
    }

    @Override
    public Race getRaceById(int id) {
        return (Race) entityManager
                .createQuery("from Race where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);
    }

    @Override
    public void addRace(Race race) {
        entityManager.persist(race);
    }

    @Override
    public void updateRace(Race race) {
        entityManager.merge(race);
    }

    @Override
    public void deleteRace(Race race) {
        Query query = entityManager.createQuery(
                "DELETE FROM Race c WHERE c.id = :id");
        query.setParameter("id", race.getId());
        query.executeUpdate();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Race> getRacesByCarClassCompetition(
            CarClassCompetition carClassCompetition) {
        Query query = entityManager
                .createQuery("from Race " +
                        "where carClassCompetition = :carClassCompetition " +
                        "order by raceNumber")
                .setParameter("carClassCompetition", carClassCompetition);

        return query.getResultList();
    }

    @Override
    public Race getRaceByNumberAndCarClassCompetition(int raceNumber, CarClassCompetition carClassCompetition) {
        Query query = entityManager.
                createQuery(" FROM Race WHERE (carClassCompetition= :carClassCompetition) AND "
                        + "(raceNumber = :raceNumber)");
        query.setParameter("carClassCompetition", carClassCompetition);
        query.setParameter("raceNumber", raceNumber);

        return (Race) query.getResultList().get(0);
    }

}
