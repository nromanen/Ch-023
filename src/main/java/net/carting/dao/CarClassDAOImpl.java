package net.carting.dao;

import net.carting.domain.CarClass;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CarClassDAOImpl implements CarClassDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public List<CarClass> getAllCarClasses() {
        return sessionFactory.getCurrentSession().createQuery("from CarClass")
                .list();
    }

    @Override
    public CarClass getCarClassById(int id) {
        return (CarClass) sessionFactory.getCurrentSession().get(CarClass.class, id);
    }

    public void addCarClass(CarClass carClass) {
        sessionFactory.getCurrentSession().save(carClass);
    }

    @Override
    public void updateCarClass(CarClass carClass) {
        sessionFactory.getCurrentSession().merge(carClass);
    }

    @Override
    public void deleteCarClass(CarClass carClass) {
        sessionFactory.getCurrentSession().delete(carClass);

    }

    @Override
    public void deleteCarClassById(int id) {
        CarClass carClass = (CarClass) sessionFactory.getCurrentSession().load(CarClass.class, id);
        sessionFactory.getCurrentSession().delete(carClass);
    }

}
