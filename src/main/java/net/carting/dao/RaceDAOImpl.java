package net.carting.dao;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.Race;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class RaceDAOImpl implements RaceDAO {
	
	private static final Logger LOG = LoggerFactory.getLogger(RaceDAOImpl.class);

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<Race> getAllRaces() {
    	LOG.debug("Get all races");
        return entityManager
                .createQuery("from Race")
                .getResultList();
    }

    @Override
    public Race getRaceById(int id) {
    	LOG.debug("Get race with id = {}", id);
        return (Race) entityManager
                .createQuery("from Race where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    @Override
    public void addRace(Race race) {
            String sql = "INSERT INTO races " +
                    "(number_of_laps, number_of_members, race_number, result_sequance, car_class_id, car_class_competition_id) " +
                    "VALUES (:laps, :members, :number, :results, :carId, :compId);";
            Query query = entityManager.createNativeQuery(sql);

            query.setParameter("laps", race.getNumberOfLaps());
            query.setParameter("members", race.getNumberOfMembers());
            query.setParameter("number", race.getRaceNumber());
            query.setParameter("results", race.getResultSequance());
            query.setParameter("carId", race.getCarClass().getId());
            query.setParameter("compId", race.getCarClassCompetition().getId());

           if ( query.executeUpdate() != 0) {
        	   LOG.debug("Added race {}", race);
           } else {
        	   LOG.warn("Tried to add race {}", race);
           }
    }

    @Override
    public void updateRace(Race race) {
        entityManager.merge(race);
        LOG.debug("Updated race with id = {}", race.getId());
    }

    @Override
    public void deleteRace(Race race) {
        Query query = entityManager.createQuery(
                "DELETE FROM Race c WHERE c.id = :id");
        query.setParameter("id", race.getId());
        if ( query.executeUpdate() != 0) {
     	   LOG.debug("Deleted race with id = {}", race.getId());
        } else {
     	   LOG.warn("Tried to delete race with id = {}", race.getId());
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Race> getRacesByCarClassCompetition(
            CarClassCompetition carClassCompetition) {
        List<Race> races;
        Query query = entityManager
                .createQuery("from Race " +
                        "where carClassCompetition = :carClassCompetition " +
                        "order by raceNumber")
                .setParameter("carClassCompetition", carClassCompetition);
        races = query.getResultList();
        LOG.debug("Get all races by car class competition with id = {}", carClassCompetition.getId());
        return races;
    }

    @Override
    public Race getRaceByNumberAndCarClassCompetition(int raceNumber, CarClassCompetition carClassCompetition) {
        Query query = entityManager.
                createQuery(" FROM Race WHERE (carClassCompetition= :carClassCompetition) AND "
                        + "(raceNumber = :raceNumber)");
        query.setParameter("carClassCompetition", carClassCompetition);
        query.setParameter("raceNumber", raceNumber);
        LOG.debug("Get race by race number({}) and car class competition(id = {})",raceNumber,  carClassCompetition.getId());
        return (Race) query.getSingleResult();
    }

}
