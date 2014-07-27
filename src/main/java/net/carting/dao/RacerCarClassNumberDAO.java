package net.carting.dao;

import net.carting.domain.CarClass;
import net.carting.domain.RacerCarClassNumber;

import java.util.List;

public interface RacerCarClassNumberDAO {

    public List<RacerCarClassNumber> getAllRacerCarClassNumbers();

    public RacerCarClassNumber getRacerCarClassNumberById(int id);

    public void addCarClass(RacerCarClassNumber racerCarClassNumber);

    public void updateCarClass(RacerCarClassNumber racerCarClassNumber);

    public void deleteCarClass(RacerCarClassNumber racerCarClassNumber);

    public List<RacerCarClassNumber> getNumbersByCarClass(CarClass carClass);

    public List<RacerCarClassNumber> getNumbersByCarClassId(int carClassId);

    public boolean isSetRacerCarClassNumberByCarClassIdAndNumber(int carClassId, int number);

    public RacerCarClassNumber getRacerCarClassNumberByCarClassIdAndRacer(int carClassId, int racerId);

    public boolean isSetCarClassByCarClassIdAndRacerId(int carClassId, int racerId);
}
