package net.carting.service;

import java.util.List;
import java.util.Map;

import net.carting.domain.*;

public interface TeamInCompetitionService {

    public boolean isTeamInCompetition(int teamId, int competitionId);

    public void addTeamInCompetition(TeamInCompetition teamInCompetition);

    public void deleteTeamInCompetition(TeamInCompetition teamInCompetition);

    public List<TeamInCompetition> getTeamInCompetitionListByTeamId(int teamId);
    
    public List<TeamInCompetition> getTeamInCompetitionListByTeamIdForCurrentYear(int teamId);

    /**
     * This method gets map(key - TeamInCompetition, value - is valid all racers from this team for this competition)
     *
     * @param teamInCompetitionList - list of registered teams in competition
     * @return map of valid and invalid teams for competition
     * @author Ivan Kozub
     */
    public Map<TeamInCompetition, Boolean> isValidTeamInCompetitionMap(List<TeamInCompetition> teamInCompetitionList);

    public void deleteTeamInCompetitionByTeamIdAndCompetitionId(int teamId, int competitionId);

    public List<Team> getTeamsByCompetitionId(int id);

    /**
     * This method gets is valid racers documents
     *
     * @param racer       - racer in which we want to check documents
     * @param competition - competition in which we want to check racers documents
     * @return <code>true</code> if all racers documents is valid,
     * and <code>false</code> if one of documents is not valid
     * @author Ivan Kozub
     */
    public boolean isValidRacerDocuments(Racer racer, Competition competition);

    /**
     * This method gets is valid document in competition
     *
     * @param document    - document which we want to check
     * @param competition - competition in which we want to check document
     * @return <code>true</code> if document is valid in competition,
     * and <code>false</code> if document is not valid
     * @author Ivan Kozub
     */
    public boolean isValidDocumentInCompetition(Document document, Competition competition);

}
