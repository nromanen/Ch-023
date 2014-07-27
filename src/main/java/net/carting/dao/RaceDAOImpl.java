package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.Race;

@Repository
public class RaceDAOImpl implements RaceDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public List<Race> getAllRaces() {
        List<Race> races = entityManager
                .createQuery("from Race")
                .getResultList();
        
        return races;
    }

    @Override
    public Race getRaceById(int id) {
        Race race = (Race) entityManager
                .createQuery("from Race where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);
        
        return race;
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
        entityManager.remove(race);
        

    }

    @Override
    public List<Race> getRacesByCarClassCompetition(
            CarClassCompetition carClassCompetition) {
        Query query = entityManager
                .createQuery("from Race " +
                        "where carClassCompetition = :carClassCompetition " +
                        "order by raceNumber")
                .setParameter("carClassCompetition", carClassCompetition);

        List<Race> races = query.getResultList();
        
        return races;
    }

    @Override
    public Race getRaceByNumberAndCarClassCompetition(int raceNumber, CarClassCompetition carClassCompetition) {
        Query query = entityManager.
                createQuery(" FROM Race WHERE (carClassCompetition= :carClassCompetition) AND "
                        + "(raceNumber = :raceNumber)");
        query.setParameter("carClassCompetition", carClassCompetition);
        query.setParameter("raceNumber", raceNumber);
        Race race = (Race) query.getResultList().get(0);
        
        return race;
    }

}
