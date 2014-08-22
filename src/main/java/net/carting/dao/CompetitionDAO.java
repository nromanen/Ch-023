package net.carting.dao;

import java.util.List;

import net.carting.domain.Competition;

public interface CompetitionDAO {

    public List<Competition> getAllCompetitions();

    public List<Competition> getAllEnabledCompetitions();

    public Competition getCompetitionById(int id);

    public void addCompetition(Competition competition);

    public void updateCompetition(Competition competition);

    public void deleteCompetition(Competition competition);

    public void setEnabled(int competitionId, boolean enabled);

    public List<Competition> getCompetitionsByYear(int year);

   /* unused method
    public List<Competition> getAllCompetitionsByPage(int page);
   */

    public List<Integer> getCompetitionsYearsList();

}
