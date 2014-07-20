package net.carting.service;

import java.util.List;

import net.carting.domain.CarClass;

public interface CarClassService {
	
	public List<CarClass> getAllCarClasses();

	public CarClass getCarClassById(int id);

	public void addCarClass(CarClass carClass);

	public void updateCarClass(CarClass carClass);

	public void deleteCarClass(CarClass carClass);

    public void deleteCarClassById(int id);

}
