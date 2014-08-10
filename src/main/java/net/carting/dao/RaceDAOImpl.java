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

            query.executeUpdate();

            /*SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
            Session session = sessionFactory.openSession();
            Transaction tx = session.beginTransaction();
            session.save(race);
            tx.commit();
            session.close();*/

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
