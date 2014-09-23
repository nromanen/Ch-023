package net.carting.dao;

import net.carting.domain.Competition;

import java.util.List;

public interface CompetitionDAO {

    public List<Competition> getAllCompetitions();

    public List<Competition> getAllEnabledCompetitions();

    public Competition getCompetitionById(int id);

    public void addCompetition(Competition competition);

    public void updateCompetition(Competition competition);

    public void deleteCompetition(Competition competition);

    public void setEnabled(int competitionId, boolean enabled);

    public List<Competition> getCompetitionsByYear(int year);

    public List<Competition> getAllCompetitionsByPage(int page, int competitionsPerPage);
    
    public long getCountOfCompetitions();

    public List<Integer> getCompetitionsYearsList();

}
