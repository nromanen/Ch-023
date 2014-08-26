package net.carting.service;

import net.carting.domain.Document;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassNumber;
import net.carting.domain.Team;

import java.util.Date;
import java.util.List;
import java.util.Set;

public interface RacerService {

    public List<Racer> getAllRacers();

    public Racer getRacerById(int id);

    public void addRacer(Racer racer);

    public void updateRacer(Racer racer);

    public void deleteRacer(Racer racer);

    public boolean isSetRacer(String firstName, String lastName, Date birthday);

    public Set<RacerCarClassNumber> parseCarClasses(String carClassesStr,
                                                    String racerCarClassNumbersStr, Racer racer);

    public Set<RacerCarClassNumber> parseUpdatedRacerCarClassNumbers(
            String updatedRacerCarClassNumbersStr, Racer racer);

    public List<Racer> getListOfRacersWithSetDocumentByDocumentType(
            int documentType);

    public Set<Racer> getSetOfRacersWithoutSetDocumentByDocumentTypeAndTeam(
            int documentType, Team team);

    public Set<Racer> getSetOfRacersNeedingPerentalPermisionByTeam(Team team);

    /**
     * <p/>
     * Sets document to racers
     *
     * @param document
     * @param racersId - array of racers
     * @see net.carting.domain.Racer
     * @see net.carting.domain.Document
     */
    public void setDocumentToRacers(Document document, String[] racersId);

	public List<Racer> getBirthdayRacers(Date checkdate);
}
