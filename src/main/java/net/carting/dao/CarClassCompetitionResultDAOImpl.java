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

    @Override
    public List<CarClassCompetitionResult> getAllCarClassCompetitionResults() {
        List<CarClassCompetitionResult> competitionResults = entityManager
                .createQuery("from CarClassCompetitionResult")
                .getResultList();
        return competitionResults;
    }

    @Override
    public CarClassCompetitionResult getCarClassCompetitionResultById(int id) {
        CarClassCompetitionResult result = (CarClassCompetitionResult) entityManager
                .createQuery("from CarClassCompetitionResult where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);
        return result;
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
        entityManager.remove(carClassCompetitionResult);
    }

    @Override
    public List<CarClassCompetitionResult> getCarClassCompetitionResultsByCarClassCompetition(
            CarClassCompetition carClassCompetition) {

        Query query = entityManager.
                createQuery("from CarClassCompetitionResult cccr where " +
                        "cccr.racerCarClassCompetitionNumber.carClassCompetition = :carClassCompetition " +
                        "order by absolutePlace");
        query.setParameter("carClassCompetition", carClassCompetition);
        List<CarClassCompetitionResult> result = query.getResultList();
        return result;
    }

    @Override
    public List<CarClassCompetitionResult> getCarClassCompetitionResultsOrderedByPoints(
            CarClassCompetition carClassCompetition) {
        Query query = entityManager.
                createQuery("from CarClassCompetitionResult cccr " +
                        "where cccr.racerCarClassCompetitionNumber.carClassCompetition = :carClassCompetition " +
                        "order by absolutePoints desc");
        query.setParameter("carClassCompetition", carClassCompetition);
        List<CarClassCompetitionResult> result = query.getResultList();
        return result;
    }

}

