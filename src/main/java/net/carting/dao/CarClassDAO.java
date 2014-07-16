package net.carting.dao;

import net.carting.domain.CarClass;

import java.util.List;

public interface CarClassDAO {

    public List<CarClass> getAllCarClasses();

    public CarClass getCarClassById(int id);

    public void addCarClass(CarClass carClass);

    public void updateCarClass(CarClass carClass);

    public void deleteCarClass(CarClass carClass);

}
