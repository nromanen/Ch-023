package net.carting.service;

import net.carting.domain.CarClass;

import java.util.List;

public interface CarClassService {

    public List<CarClass> getAllCarClasses();

    public CarClass getCarClassById(int id);

    public void addCarClass(CarClass carClass);

    public void updateCarClass(CarClass carClass);

    public void deleteCarClass(CarClass carClass);

    public void deleteCarClassById(int id);

}
