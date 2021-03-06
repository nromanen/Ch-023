package net.carting.service;

import net.carting.dao.CarClassDAO;
import net.carting.domain.CarClass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CarClassServiceImpl implements CarClassService {

    @Autowired
    private CarClassDAO carClassDAO;

    @Override
    @Transactional
    public List<CarClass> getAllCarClasses() {
        return carClassDAO.getAllCarClasses();
    }

    @Override
    @Transactional
    public CarClass getCarClassById(int id) {
        return carClassDAO.getCarClassById(id);
    }

    @Override
    @Transactional
    public void addCarClass(CarClass carClass) {
        carClassDAO.addCarClass(carClass);
    }

    @Override
    @Transactional
    public void updateCarClass(CarClass carClass) {
        carClassDAO.updateCarClass(carClass);
    }

    @Override
    @Transactional
    public void deleteCarClass(CarClass carClass) {
        carClassDAO.deleteCarClass(carClass);
    }

    @Override
    @Transactional
    public void deleteCarClassById(int id) {
        carClassDAO.deleteCarClassById(id);
    }

}
