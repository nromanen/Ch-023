package net.carting.dao;

import net.carting.domain.CarClass;
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
                .getSingleResult();
    }

    @Override
    public void addRace(Race race) {
        /*System.out.println(race.getId());
        System.out.print("\tResults: " + race.getResultSequance());
        System.out.print("\tMembers: " + race.getNumberOfMembers());
        System.out.print("\tRaceNumber: " + race.getRaceNumber());
        System.out.print("\tCarClassCompetition: " + race.getCarClassCompetition().getId());
        System.out.print("\tCarClass: " + race.getCarClass().getId());
        System.out.print("\tLaps: " + race.getNumberOfLaps());*/
        try {
            /*int carClassCompetitionId = race.getCarClassCompetition().getId();
            CarClassCompetition carClassCompetition = entityManager.find(CarClassCompetition.class, carClassCompetitionId);
            carClassCompetition.getRaces().add(race);
            entityManager.merge(carClassCompetition);*/

            //Race r = entityManager.find(Race.class, race.getId());
            int carClassCompetitionId = race.getCarClassCompetition().getId();
            CarClassCompetition carClassCompetition = entityManager.find(CarClassCompetition.class, carClassCompetitionId);

            int carClassId = race.getCarClass().getId();
            CarClass carClass = entityManager.find(CarClass.class, carClassId);


            race.setCarClass(carClass);
            race.setCarClassCompetition(carClassCompetition);

            entityManager.persist(race);
        } catch (Exception e) {
            e.printStackTrace();
        }

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

        return (Race) query.getSingleResult();
    }

}
