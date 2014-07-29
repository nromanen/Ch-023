package net.carting.dao;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.CarClassCompetitionResult;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class CarClassCompetitionResultDAOImpl implements CarClassCompetitionResultDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<CarClassCompetitionResult> getAllCarClassCompetitionResults() {
        return entityManager
                .createQuery("from CarClassCompetitionResult")
                .getResultList();
    }

    @Override
    public CarClassCompetitionResult getCarClassCompetitionResultById(int id) {
        return (CarClassCompetitionResult) entityManager
                .createQuery("from CarClassCompetitionResult where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);
    }

    @Override
    public void addCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult) {
        entityManager.persist(carClassCompetitionResult);
    }

    @Override
    public void updateCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult) {
        entityManager.merge(carClassCompetitionResult);
    }

    @Override
    public void deleteCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult) {
        Query query = entityManager.createQuery(
                "DELETE FROM CarClassCompetitionResult c WHERE c.id = :id");
        query.setParameter("id", carClassCompetitionResult.getId());
        query.executeUpdate();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<CarClassCompetitionResult> getCarClassCompetitionResultsByCarClassCompetition(
            CarClassCompetition carClassCompetition) {

        Query query = entityManager.
                createQuery("from CarClassCompetitionResult cccr where " +
                        "cccr.racerCarClassCompetitionNumber.carClassCompetition = :carClassCompetition " +
                        "order by absolutePlace");
        query.setParameter("carClassCompetition", carClassCompetition);
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<CarClassCompetitionResult> getCarClassCompetitionResultsOrderedByPoints(
            CarClassCompetition carClassCompetition) {
        Query query = entityManager.
                createQuery("from CarClassCompetitionResult cccr " +
                        "where cccr.racerCarClassCompetitionNumber.carClassCompetition = :carClassCompetition " +
                        "order by absolutePoints desc");
        query.setParameter("carClassCompetition", carClassCompetition);
        return query.getResultList();
    }

}

