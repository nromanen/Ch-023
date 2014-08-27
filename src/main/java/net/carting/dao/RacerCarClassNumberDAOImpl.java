package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.CarClass;
import net.carting.domain.RacerCarClassNumber;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;


@Repository
public class RacerCarClassNumberDAOImpl implements RacerCarClassNumberDAO {
	
	private static final Logger LOG = LoggerFactory.getLogger(RacerCarClassNumberDAOImpl.class);

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<RacerCarClassNumber> getAllRacerCarClassNumbers() {
    	LOG.debug("Get all racerCarClassNumber");
        return entityManager
                .createQuery("from RacerCarClassNumber")
                .getResultList();
    }

    @Override
    public RacerCarClassNumber getRacerCarClassNumberById(int id) {
    	LOG.debug("Get racerCarClassNumber with id = {}", id);
        return (RacerCarClassNumber) entityManager
                .createQuery("from RacerCarClassNumber where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    @Override
    public void addCarClass(RacerCarClassNumber racerCarClassNumber) {
        entityManager.persist(racerCarClassNumber);
        LOG.debug("Add racerCarClassNumber {}", racerCarClassNumber);
    }

    @Override
    public void updateCarClass(RacerCarClassNumber racerCarClassNumber) {
        entityManager.merge(racerCarClassNumber);
        LOG.debug("Updated racerCarClassNumber with id = {}", racerCarClassNumber.getId());
    }

    @Override
    public void deleteCarClass(RacerCarClassNumber racerCarClassNumber) {
        Query query = entityManager.createQuery(
                "DELETE FROM RacerCarClassNumber c WHERE c.id = :id");
        query.setParameter("id", racerCarClassNumber.getId());
        if (query.executeUpdate() != 0) {
        	LOG.debug("Deleted racerCarClassNumber with id = {}", racerCarClassNumber.getId());
        } else {
        	LOG.warn("Tried to delete racerCarClassNumber with id = {}", racerCarClassNumber.getId());
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<RacerCarClassNumber> getNumbersByCarClass(CarClass carClass) {
        Query query = entityManager.createQuery("from RacerCarClassNumber where carClass= :carClass ");
        query.setParameter("carClass", carClass);
        
        LOG.debug("Get racerCarClassNumbers by carClass with id = {}", carClass.getId());
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<RacerCarClassNumber> getNumbersByCarClassId(int carClassId) {
        Query query = entityManager
                .createQuery("from RacerCarClassNumber where carClass.id = :carClassId ")
                .setParameter("carClassId", carClassId);
        LOG.debug("Get racerCarClassNumbers by carClassId = {}", carClassId);
        return query.getResultList();
    }

    @Override
    public boolean isSetRacerCarClassNumberByCarClassIdAndNumber(int carClassId, int number) {
        Query query = entityManager.
                createNativeQuery("SELECT * FROM racer_car_class_numbers "
                        + "WHERE car_class_id = :car_class_id AND "
                        + "number = :number");
        //TODO: Was: .addEntity(RacerCarClassNumber.class); Need to test, if it works ok without this line. UPD: 29/07/14 Seems to work ok.
        query.setParameter("car_class_id", Integer.toString(carClassId));
        query.setParameter("number", Integer.toString(number));
        List result = query.getResultList();
        
        LOG.debug("RacerCarClassNumber is {} set.(carClassId = {}, number = {})", !result.isEmpty() ? "" : "not", carClassId, number);
        return !result.isEmpty();
    }

    @Override
    public RacerCarClassNumber getRacerCarClassNumberByCarClassIdAndRacer(int carClassId, int racerId) {
        Query query = entityManager.
                createQuery("FROM RacerCarClassNumber rccn "
                        + "WHERE rccn.carClass.id = :carClassId AND "
                        + "rccn.racer.id = :racerId");
        query.setParameter("carClassId", carClassId);
        query.setParameter("racerId", racerId);
        LOG.debug("Get racerCarClassNumber by carClassId({}) and racerId({})", carClassId, racerId);
        return (RacerCarClassNumber) query.getSingleResult();
    }

    @Override
    public boolean isSetCarClassByCarClassIdAndRacerId(int carClassId, int racerId) {
        String sqlQuery = "SELECT * FROM racer_car_class_numbers WHERE car_class_id = :carClassId AND racer_id = :racerId";
        Query query = entityManager
                .createNativeQuery(sqlQuery).
                        setParameter("carClassId", carClassId).
                        setParameter("racerId", racerId);
        List result = query.getResultList();

        LOG.debug("RacerCarClassNumber is {} set.(carClassId = {}, racerId = {})", !result.isEmpty() ? "" : "not", carClassId, racerId);
        return !result.isEmpty();
    }

}
