package net.carting.dao;

import net.carting.domain.CarClass;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Competition;
import net.carting.domain.Race;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;
import java.util.Set;

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
            /*Team team = entityManager.find(Team.class, racer.getTeam().getId());
            Set<Racer> racers = team.getRacers();
            racers.add(racer);
            team.setRacers(racers);
            entityManager.persist(racer);
            entityManager.merge(team);*/
            String sql = "INSERT INTO races " +
                    "(number_of_laps, number_of_members, race_number, result_sequance, car_class_id) " +
                    "VALUES (:laps, :members, :number, :results, :carId);";
            Query query = entityManager.createNativeQuery(sql);

            query.setParameter("laps", race.getNumberOfLaps());
            query.setParameter("members", race.getNumberOfMembers());
            query.setParameter("number", race.getRaceNumber());
            query.setParameter("results", race.getResultSequance());
            query.setParameter("carId", race.getCarClass().getId());

            query.executeUpdate();

           /* CarClassCompetition competition = entityManager.find(CarClassCompetition.class, race.getCarClassCompetition().getId());
            Set<Race> races = competition.getRaces();
            races.add(race);
            competition.setRaces(races);

            CarClass carClass = entityManager.find(CarClass.class, race.getCarClass().getId());
            race.setCarClass(carClass);

            entityManager.merge(competition);
            entityManager.persist(race);*/
            //int carClassCompetitionId = race.getCarClassCompetition().getId();
            //CarClassCompetition carClassCompetition = entityManager.find(CarClassCompetition.class, carClassCompetitionId);

            //int carClassId = race.getCarClass().getId();
            //CarClass carClass = entityManager.find(CarClass.class, carClassId);


            //race.setCarClass(carClass);
            //race.setCarClassCompetition(carClassCompetition);


        } catch (Exception e) {
            System.out.println("addRace");
//            e.printStackTrace();
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
        List<Race> races = null;
        Query query = entityManager
                .createQuery("from Race " +
                        "where carClassCompetition = :carClassCompetition " +
                        "order by raceNumber")
                .setParameter("carClassCompetition", carClassCompetition);
        races = query.getResultList();
        return races;
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
