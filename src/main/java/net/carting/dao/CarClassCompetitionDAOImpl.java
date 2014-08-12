package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.CarClassCompetition;

import org.springframework.stereotype.Repository;

@Repository
public class CarClassCompetitionDAOImpl implements CarClassCompetitionDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<CarClassCompetition> getAllCarClassCompetitions() {

        return entityManager
                .createQuery("from CarClassCompetition").getResultList();
    }

    @Override
    public CarClassCompetition getCarClassCompetitionById(int id) {
        return (CarClassCompetition) entityManager
                .createQuery("from CarClassCompetition where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    @Override
    public void addCarClassCompetition(CarClassCompetition carClassCompetition) {
        entityManager.persist(carClassCompetition);

    }

    @Override
    public void updateCarClassCompetition(CarClassCompetition carClassCompetition) {
        Query query = entityManager.createQuery("UPDATE CarClassCompetition "
                + "SET firstRaceTime = :firstRaceTime, "
                + "secondRaceTime = :secondRaceTime, "
                + "circleCount = :circleCount, "
                + "percentageOffset = :percentageOffset "
                + "WHERE id = :id");

        query.setParameter("firstRaceTime", carClassCompetition.getFirstRaceTime());
        query.setParameter("secondRaceTime", carClassCompetition.getSecondRaceTime());

        query.setParameter("circleCount", carClassCompetition.getCircleCount());
        query.setParameter("percentageOffset", carClassCompetition.getPercentageOffset());
        query.setParameter("id", carClassCompetition.getId());

        query.executeUpdate();
    }

    @Override
    public void deleteCarClassCompetition(CarClassCompetition carClassCompetition) {
        Query query = entityManager.createQuery(
                "DELETE FROM CarClassCompetition c WHERE c.id = :id");
        query.setParameter("id", carClassCompetition.getId());
        query.executeUpdate();
//        CarClassCompetition competition = entityManager.find(CarClassCompetition.class, carClassCompetition.getId());
//        entityManager.remove(competition);
// Doesn't work. No exception, simply doesn't delete from DB.
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<CarClassCompetition> getCarClassCompetitionsByCompetitionId(int competitionId) {
        Query query = entityManager.
                createQuery("FROM CarClassCompetition ccc "
                        + "WHERE ccc.competition.id = :id "
                        + "ORDER BY ccc.carClass.name");
        query.setParameter("id", competitionId);
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<CarClassCompetition> getCarClassCompetitionsByCarClassId(int carClassId) {
        Query query = entityManager.
                createQuery("FROM CarClassCompetition ccc "
                        + "WHERE ccc.carClass.id = :id "
                        + "ORDER BY ccc.carClass.name");
        query.setParameter("id", carClassId);
        return query.getResultList();
    }


}
