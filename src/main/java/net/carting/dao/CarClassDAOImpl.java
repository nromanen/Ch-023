package net.carting.dao;

import net.carting.domain.CarClass;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class CarClassDAOImpl implements CarClassDAO {

	private static final Logger LOG = LoggerFactory.getLogger(CarClassDAOImpl.class);
	
    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<CarClass> getAllCarClasses() {
    	LOG.debug("Get all car classes");
        return entityManager
                .createQuery("from CarClass").getResultList();
    }

    @Override
    public CarClass getCarClassById(int id) {
    	LOG.debug("Get car class with id = {}", id);
        return (CarClass) entityManager
                .createQuery("from CarClass where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    public void addCarClass(CarClass carClass) {
        entityManager.persist(carClass);
    	LOG.debug("Add car class {}", carClass);
    }

    @Override
    public void updateCarClass(CarClass carClass) {
        entityManager.merge(carClass);
    	LOG.debug("Update car class with id = {}", carClass.getId());
    }

    @Override
    public void deleteCarClass(CarClass carClass) {
        deleteCarClassById(carClass.getId());
    }

    @Override
    public void deleteCarClassById(int id) {
        CarClass carClass = entityManager.find(CarClass.class, id);
        entityManager.remove(carClass);
        LOG.debug("Delete car class with id = {}", id);
    }
}
