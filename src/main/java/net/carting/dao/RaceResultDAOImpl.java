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
                .getSingleResult();
    }

    @Override
    public void addRaceResult(RaceResult raceResult) {
        try {
//            System.out.println("########################################################");
            String sql = "INSERT INTO race_results " +
                    "(car_number, full_laps, place, points, race_id, racer_id) " +
                    "VALUES (:car, :laps, :place, :points, :race, :racer)";
            Query query = entityManager.createNativeQuery(sql);

            query.setParameter("car", raceResult.getCarNumber());
            query.setParameter("laps", raceResult.getFullLaps());
            query.setParameter("place", raceResult.getPlace());
            query.setParameter("points", raceResult.getPoints());
            query.setParameter("race",raceResult.getRace().getId() );
            query.setParameter("racer", raceResult.getRacer().getId());
            System.out.println(raceResult.getCarNumber() +
                    "\t" + raceResult.getFullLaps() +
                    "\t" + raceResult.getPlace() +
                    "\t" + raceResult.getPoints() +
                    "\t" + raceResult.getRace().getId() +
                    "\t" + raceResult.getRacer().getId());
            query.executeUpdate();

//            System.out.println("########################################################");
        } catch (Exception e) {
            System.out.println("addRaceResult");
//            e.printStackTrace();
        }
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
        List<RaceResult> list = null;
        try {
            list = entityManager
                    .createQuery("from RaceResult where race= :race order by place ")
                    .setParameter("race", race)
                    .getResultList();
        } catch (Exception e) {
            System.out.println("getRaceResultsByRace");
        }
        return list;
    }

    @Override
    public RaceResult getRaceResultByRaceNumberAndRacer(int raceNumber, Racer racer) {
        Query query = entityManager.
                createQuery("FROM RaceResult rr "
                        + "WHERE rr.race.raceNumber  = :raceNumber AND racer=:racer");
        query.setParameter("raceNumber", raceNumber);
        query.setParameter("racer", racer);

        return (RaceResult) query.getSingleResult();
    }

}
