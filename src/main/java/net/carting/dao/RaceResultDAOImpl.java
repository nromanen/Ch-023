package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.Race;
import net.carting.domain.RaceResult;
import net.carting.domain.Racer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class RaceResultDAOImpl implements RaceResultDAO {
	
	private static final Logger LOG = LoggerFactory.getLogger(RaceResultDAOImpl.class);

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<RaceResult> getAllRaceResults() {
    	LOG.debug("Get all raceResults");
        return entityManager.createQuery("from RaceResult").getResultList();
    }

    @Override
    public RaceResult getRaceResultById(int id) {
    	LOG.debug("Get race result with id = {}", id);
        return (RaceResult) entityManager
                .createQuery("from RaceResult where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    @Override
    public void addRaceResult(RaceResult raceResult) {
            Race race = raceResult.getRace();

            String sql = "INSERT INTO race_results " +
                    "(car_number, full_laps, place, points, race_id, racer_id) " +
                    "VALUES (:car, :laps, :place, :points, :race, :racer)";
            Query query = entityManager.createNativeQuery(sql);

            query.setParameter("car", raceResult.getCarNumber());
            query.setParameter("laps", raceResult.getFullLaps());
            query.setParameter("place", raceResult.getPlace());
            query.setParameter("points", raceResult.getPoints());
            query.setParameter("race", race.getId());
            query.setParameter("racer", raceResult.getRacer().getId());
            if (query.executeUpdate() != 0) {
            	LOG.debug("Added raceResult {}", raceResult);
            } else {
            	LOG.warn("Tried to add raceResult {}", raceResult);
            }
    }

    @Override
    public void updateRaceResult(RaceResult raceResult) {
        entityManager.merge(raceResult);
        LOG.debug("Updated raceResult with id = {}", raceResult.getId());
    }

    @Override
    public void deleteRaceResult(RaceResult raceResult) {
        Query query = entityManager.createQuery(
                "DELETE FROM RaceResult c WHERE c.id = :id");
        query.setParameter("id", raceResult.getId());
        if (query.executeUpdate() != 0) {
        	LOG.debug("Deleted raceResult with id = {}", raceResult.getId());
        } else {
        	LOG.warn("Tried to delete raceResult with id = {}", raceResult.getId());
        }

    }

    @SuppressWarnings("unchecked")
    @Override
    public List<RaceResult> getRaceResultsByRace(Race race) {
        List<RaceResult> list = null;
        list = entityManager
                .createQuery("from RaceResult where race= :race order by place ")
                .setParameter("race", race)
                .getResultList();
        LOG.debug("Get race results by race with id = {}", race.getId());
        return list;
    }
    
    @SuppressWarnings("unchecked")
    @Override
    public RaceResult getRaceResultsByRaceAndRacer(Race race, Racer racer) {
        	Query q = entityManager
                    .createQuery("from RaceResult where race= :race AND racer= :racer");
        	q.setParameter("race", race);
        	q.setParameter("racer", racer);
        	LOG.debug("Get race results by race(id = {}) and racer(id = {})", race.getId(), racer.getId());
        return (RaceResult) q.getSingleResult();
    }

    @Override
    public RaceResult getRaceResultByRaceNumberAndRacer(int raceNumber, Racer racer) {
        Query query = entityManager.
                createQuery("FROM RaceResult rr "
                        + "WHERE rr.race.raceNumber  = :raceNumber AND racer=:racer");
        query.setParameter("raceNumber", raceNumber);
        query.setParameter("racer", racer);
        LOG.debug("Get race results by raceNumber({}) and racer(id = {})", raceNumber, racer.getId());
        return (RaceResult) query.getSingleResult();
    }
}
