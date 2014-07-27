package net.carting.service;

import net.carting.dao.RacerCarClassNumberDAO;
import net.carting.domain.CarClass;
import net.carting.domain.RacerCarClassNumber;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class RacerCarClassNumberServiceImpl implements
        RacerCarClassNumberService {

    @Autowired
    private RacerCarClassNumberDAO racerCarClassNumberDAO;

    @Override
    @Transactional
    public List<RacerCarClassNumber> getAllRacerCarClassNumbers() {
        return racerCarClassNumberDAO.getAllRacerCarClassNumbers();
    }

    @Override
    @Transactional
    public RacerCarClassNumber getRacerCarClassNumberById(int id) {
        return racerCarClassNumberDAO.getRacerCarClassNumberById(id);
    }

    @Override
    @Transactional
    public void addRacerCarClassNumber(RacerCarClassNumber racerCarClassNumber) {
        racerCarClassNumberDAO.addCarClass(racerCarClassNumber);
    }

    @Override
    @Transactional
    public void updateRacerCarClassNumber(RacerCarClassNumber racerCarClassNumber) {
        racerCarClassNumberDAO.updateCarClass(racerCarClassNumber);
    }

    @Override
    @Transactional
    public void deleteRacerCarClassNumber(RacerCarClassNumber racerCarClassNumber) {
        racerCarClassNumberDAO.deleteCarClass(racerCarClassNumber);
    }

    @Override
    @Transactional
    public List<RacerCarClassNumber> getNumbersByCarClass(CarClass carClass) {
        return racerCarClassNumberDAO.getNumbersByCarClass(carClass);
    }

    @Override
    @Transactional
    public List<RacerCarClassNumber> getNumbersByCarClassId(int carClassId) {
        return racerCarClassNumberDAO.getNumbersByCarClassId(carClassId);
    }

    @Override
    @Transactional
    public String getNumbersByCarClassId(int carClassId, String separator) {
        List<RacerCarClassNumber> racerCarClassNumbers = racerCarClassNumberDAO.getNumbersByCarClassId(carClassId);
        StringBuilder result = new StringBuilder();
        for (RacerCarClassNumber racerCarClassNumber : racerCarClassNumbers) {
            result.append(racerCarClassNumber.getNumber());
            result.append(separator);
        }
        return result.toString();
    }

    @Override
    @Transactional
    public boolean isSetRacerCarClassNumberByCarClassIdAndNumber(int carClassId, int number) {
        return racerCarClassNumberDAO.isSetRacerCarClassNumberByCarClassIdAndNumber(carClassId, number);
    }

    @Override
    @Transactional
    public RacerCarClassNumber getRacerCarClassNumberByCarClassIdAndRacer(int carClassId, int racerId) {
        return racerCarClassNumberDAO.getRacerCarClassNumberByCarClassIdAndRacer(carClassId, racerId);
    }

    @Override
    @Transactional
    public boolean isSetCarClassByCarClassIdAndRacerId(int carClassId, int racerId) {
        return racerCarClassNumberDAO.isSetCarClassByCarClassIdAndRacerId(carClassId, racerId);
    }
}
