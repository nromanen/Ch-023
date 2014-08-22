package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.CarClassCompetitionResult;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class CarClassCompetitionResultDAOImpl implements CarClassCompetitionResultDAO {

	private static final Logger LOG = LoggerFactory.getLogger(CarClassCompetitionResultDAOImpl.class);
	
    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<CarClassCompetitionResult> getAllCarClassCompetitionResults() {
    	LOG.debug("Get all car class competition results, returned type - List<CarClassCompetitionResult>");
        return entityManager
                .createQuery("from CarClassCompetitionResult")
                .getResultList();
    }

    @Override
    public CarClassCompetitionResult getCarClassCompetitionResultById(int id) {
    	LOG.debug("Get car class competition result by id = {}", id);
        return (CarClassCompetitionResult) entityManager
                .createQuery("from CarClassCompetitionResult where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    @Override
    public void addCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult) {
        entityManager.persist(carClassCompetitionResult);
        
        LOG.debug("Added car class competition result {}", carClassCompetitionResult);
    }

    @Override
    public void updateCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult) {
        entityManager.merge(carClassCompetitionResult);
        LOG.debug("Updated car class competition result with id = {}", carClassCompetitionResult.getId());
    }

    @Override
    public void deleteCarClassCompetitionResult(CarClassCompetitionResult carClassCompetitionResult) {
        Query query = entityManager.createQuery(
                "DELETE FROM CarClassCompetitionResult c WHERE c.id = :id");
        query.setParameter("id", carClassCompetitionResult.getId());
        if (query.executeUpdate() != 0) {
        	LOG.debug("Deleted car class competition result with id = {}", carClassCompetitionResult.getId());
        }
        else {
        	LOG.debug("Trying to delete car class competition result with id = {}", carClassCompetitionResult.getId());
        }
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
        LOG.debug("Get car class competition results by car class competition with id = {} ordered by absolute place", carClassCompetition.getId());
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
        LOG.debug("Get car class competition results by car class competition with id = {} ordered by points", carClassCompetition.getId());
        return query.getResultList();
    }

}

