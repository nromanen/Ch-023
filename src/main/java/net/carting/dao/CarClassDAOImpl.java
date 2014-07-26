package net.carting.dao;

import net.carting.domain.CarClass;
import net.carting.util.EntityManagerUtil;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CarClassDAOImpl implements CarClassDAO {

    @Override
    public List<CarClass> getAllCarClasses() {
        List<CarClass> carClassList = EntityManagerUtil.getEntityManager().
            createQuery("from CarClass").getResultList();
        EntityManagerUtil.closeTransaction();
        return carClassList;
    }

    @Override
    public CarClass getCarClassById(int id) {
        CarClass carClass = EntityManagerUtil.getEntityManager().getReference(CarClass.class, id);
        EntityManagerUtil.closeTransaction();
        return carClass;
    }

    public void addCarClass(CarClass carClass) {
        EntityManagerUtil.getEntityManager().persist(carClass);
        EntityManagerUtil.closeTransaction();
    }

    @Override
    public void updateCarClass(CarClass carClass) {
        EntityManagerUtil.getEntityManager().merge(carClass);
        EntityManagerUtil.closeTransaction();
    }

    @Override
    public void deleteCarClass(CarClass carClass) {
        EntityManagerUtil.getEntityManager().remove(carClass);
        EntityManagerUtil.closeTransaction();

    }

    @Override
    public void deleteCarClassById(int id) {
        CarClass carClass = (CarClass) EntityManagerUtil.getEntityManager().getReference(CarClass.class, id);
        EntityManagerUtil.closeTransaction();
        EntityManagerUtil.getEntityManager().remove(carClass);
        EntityManagerUtil.closeTransaction();
    }

}
