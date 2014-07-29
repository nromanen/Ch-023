package net.carting.dao;

import net.carting.domain.Race;
import net.carting.domain.RaceResult;
import net.carting.domain.Racer;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class RaceResultDAOImpl implements RaceResultDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<RaceResult> getAllRaceResults() {
        return entityManager.createQuery("from RaceResult").getResultList();
    }

    @Override
    public RaceResult getRaceResultById(int id) {
        return (RaceResult) entityManager
                .createQuery("from RaceResult where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);
    }

    @Override
    public void addRaceResult(RaceResult raceResult) {
        entityManager.persist(raceResult);
    }

    @Override
    public void updateRaceResult(RaceResult raceResult) {
        entityManager.merge(raceResult);
    }

    @Override
    public void deleteRaceResult(RaceResult raceResult) {
        Query query = entityManager.createQuery(
                "DELETE FROM RaceResult c WHERE c.id = :id");
        query.setParameter("id", raceResult.getId());
        query.executeUpdate();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<RaceResult> getRaceResultsByRace(Race race) {
        return entityManager
                .createQuery("from RaceResult where race= :race order by place ")
                .setParameter("race", race)
                .getResultList();
    }

    @Override
    public RaceResult getRaceResultByRaceNumberAndRacer(int raceNumber, Racer racer) {
        Query query = entityManager.
                createQuery("FROM RaceResult rr "
                        + "WHERE rr.race.raceNumber  = :raceNumber AND racer=:racer");
        query.setParameter("raceNumber", raceNumber);
        query.setParameter("racer", racer);

        return (RaceResult) query.getResultList().get(0);
    }

}
