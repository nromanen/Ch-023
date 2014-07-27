package net.carting.service;

import net.carting.domain.CarClass;
import net.carting.domain.RacerCarClassNumber;

import java.util.List;

public interface RacerCarClassNumberService {

    public List<RacerCarClassNumber> getAllRacerCarClassNumbers();

    public RacerCarClassNumber getRacerCarClassNumberById(int id);

    public void addRacerCarClassNumber(RacerCarClassNumber racerCarClassNumber);

    public void updateRacerCarClassNumber(RacerCarClassNumber racerCarClassNumber);

    public void deleteRacerCarClassNumber(RacerCarClassNumber racerCarClassNumber);

    public List<RacerCarClassNumber> getNumbersByCarClass(CarClass carClass);

    public List<RacerCarClassNumber> getNumbersByCarClassId(int carClassId);

    public String getNumbersByCarClassId(int carClassId, String separator);

    public boolean isSetRacerCarClassNumberByCarClassIdAndNumber(int carClassId, int number);

    public RacerCarClassNumber getRacerCarClassNumberByCarClassIdAndRacer(int carClassId, int racerId);

    public boolean isSetCarClassByCarClassIdAndRacerId(int carClassId, int racerId);
}
