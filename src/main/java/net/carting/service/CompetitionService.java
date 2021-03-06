package net.carting.service;

import net.carting.domain.*;

import java.util.List;

public interface CompetitionService {

    public List<Competition> getAllCompetitions();

    public List<Competition> getAllEnabledCompetitions();

    public List<Competition> getCompetitionsByYear(int year);

    public List<Competition> getAllCompetitionsByPage(int page, int competitionsPerPage);
    
    public long getCountOfCompetitions();

    public Competition getCompetitionById(int id);

    public void addCompetition(Competition competition);

    public void updateCompetition(Competition competition);

    public void deleteCompetition(Competition competition);

    public void setEnabled(int competitionId, boolean enabled);

    /**
     * This method gets list of years in which there are competitions.
     *
     * @return List of years in which there are competitions
     * @author Ivan Kozub
     */
    public List<Integer> getCompetitionsYearsList();

    /**
     * This method gets carClasses which are not contained in carClassCompetitions.
     *
     * @param carClasses           - list of all car classes
     * @param carClassCompetitions - list of car classes of competition
     * @return List of car classes which are not contained in carClassCompetitions
     * @author Ivan Kozub
     */
    public List<CarClass> getDifferenceBetweenCarClassesAndCarClassCompetitions(List<CarClass> carClasses,
                                                                                List<CarClassCompetition> carClassCompetitions);

    /**
     * This method gets list of unique teams from list of registered racers.
     *
     * @param racerCarClassCompetitionNumbers - list of registered racers
     * @return List of unique teams from list of registered racers
     * @author Ivan Kozub
     */
    public List<Team> getTeamsFromRacerCarClassCompetitionNumbers(
            List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumbers);
    
    public List<String> getPointsByPlacesList(Competition competition);

}
