package net.carting.service;

import java.util.Date;
import java.util.List;
import java.util.Set;

import net.carting.domain.Document;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassNumber;
import net.carting.domain.Team;

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

    /**
     * This method get all racers of current team without documents of defined type.
     * 
     *  @param documentType Constant of {@link net.carting.domain.Document}, type of the document.
     *  @param team Racers team
     *  @return Set of racers without such document.
     * 
     * */
    public Set<Racer> getSetOfRacersWithoutSetDocumentByDocumentTypeAndTeam(
            int documentType, Team team);

    /**
     * This method get all racers of the current team, that must have parental permission
     * 
     * @param team Object of the racers team
     * @return Set of racers, that must have parental permission
     * 
     * */
    public Set<Racer> getSetOfRacersNeedingPerentalPermisionByTeam(Team team);
    
    public List<Racer> getBirthdayRacers(Date checkdate);

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
}
