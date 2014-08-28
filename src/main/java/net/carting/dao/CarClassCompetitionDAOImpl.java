package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.CarClassCompetition;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class CarClassCompetitionDAOImpl implements CarClassCompetitionDAO {

	private static final Logger LOG = LoggerFactory.getLogger(CarClassCompetitionDAOImpl.class);
	
    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<CarClassCompetition> getAllCarClassCompetitions() {
    	LOG.debug("Get all car class competitions");
        return entityManager
                .createQuery("from CarClassCompetition").getResultList();
    }

    @Override
    public CarClassCompetition getCarClassCompetitionById(int id) {
    	LOG.debug("Get car class competition with id = {}", id);
        return (CarClassCompetition) entityManager
                .createQuery("from CarClassCompetition where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    @Override
    public void addCarClassCompetition(CarClassCompetition carClassCompetition) {
        entityManager.persist(carClassCompetition);
        
        LOG.debug("Add car class competition {}", carClassCompetition);

    }

    @Override
    public void updateCarClassCompetition(CarClassCompetition carClassCompetition) {
        try {
            entityManager.merge(carClassCompetition);
        } catch (Exception e) {
            e.printStackTrace();
        }
        LOG.debug("Updated car class competition with id = {}", carClassCompetition.getId());
    }

    @Override
    public void deleteCarClassCompetition(CarClassCompetition carClassCompetition) {
        Query query = entityManager.createQuery(
                "DELETE FROM CarClassCompetition c WHERE c.id = :id");
        query.setParameter("id", carClassCompetition.getId());
        
        if (query.executeUpdate() != 0) {
        	LOG.debug("Deleted car class competition with id = {}", carClassCompetition.getId());
        } else {
        	LOG.debug("Trying to delete car class competition with id = {}", carClassCompetition.getId());
        }

    }

    @SuppressWarnings("unchecked")
    @Override
    public List<CarClassCompetition> getCarClassCompetitionsByCompetitionId(int competitionId) {
        Query query = entityManager.
                createQuery("FROM CarClassCompetition ccc "
                        + "WHERE ccc.competition.id = :id "
                        + "ORDER BY ccc.carClass.name");
        query.setParameter("id", competitionId);
        LOG.debug("Get car class competititon by competitionId = {}", competitionId);
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
        
        LOG.debug("Get car class competition by carClassId = {}", carClassId);
        return query.getResultList();
    }


}
