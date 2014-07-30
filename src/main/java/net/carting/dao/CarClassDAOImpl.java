package net.carting.dao;

import net.carting.domain.CarClass;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class CarClassDAOImpl implements CarClassDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<CarClass> getAllCarClasses() {
        return entityManager
                .createQuery("from CarClass").getResultList();
    }

    @Override
    public CarClass getCarClassById(int id) {
        return (CarClass) entityManager
                .createQuery("from CarClass where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    public void addCarClass(CarClass carClass) {
        entityManager.persist(carClass);
    }

    @Override
    public void updateCarClass(CarClass carClass) {
        entityManager.merge(carClass);
    }

    @Override
    public void deleteCarClass(CarClass carClass) {
        deleteCarClassById(carClass.getId());
    }

    @Override
    public void deleteCarClassById(int id) {
        CarClass carClass = entityManager.find(CarClass.class, id);
        entityManager.remove(carClass);
        /*Query query = entityManager.createQuery(
                "DELETE FROM CarClass c WHERE c.id = :id");
        query.setParameter("id", id);
        query.executeUpdate();*/
    }

}
