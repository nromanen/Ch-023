package net.carting.dao;

import net.carting.domain.CarClass;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class CarClassDAOImpl implements CarClassDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public List<CarClass> getAllCarClasses() {
        List<CarClass> carClassList = entityManager
                .createQuery("from CarClass").getResultList();
        return carClassList;
    }

    @Override
    public CarClass getCarClassById(int id) {
        CarClass carClass = (CarClass) entityManager
                .createQuery("from CarClass where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);
        return carClass;
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
        entityManager.remove(carClass);
    }

    @Override
    public void deleteCarClassById(int id) {
        CarClass carClass = (CarClass) entityManager.getReference(CarClass.class, id);
        entityManager.remove(carClass);
    }

}
