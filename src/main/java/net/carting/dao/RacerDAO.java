package net.carting.dao;

import net.carting.domain.Racer;

import java.util.Date;
import java.util.List;

public interface RacerDAO {

    public List<Racer> getAllRacers();

    public Racer getRacerById(int id);

    public void addRacer(Racer racer);

    public void updateRacer(Racer racer);

    public void deleteRacer(Racer racer);

    public boolean isSetRacer(String firstName, String lastName, Date birthday);

    public List<Racer> getListOfRacersWithSetDocumentByDocumentType(
            int documentType);

}
