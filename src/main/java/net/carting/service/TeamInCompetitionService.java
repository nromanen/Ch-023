package net.carting.service;

import java.util.List;
import java.util.Map;

import net.carting.domain.TeamInCompetition;

public interface TeamInCompetitionService {

    public boolean isTeamInCompetition(int teamId, int competitionId);
    
    public void addTeamInCompetition(TeamInCompetition teamInCompetition);
    
    public void deleteTeamInCompetition(TeamInCompetition teamInCompetition);
    
    public List<TeamInCompetition> getTeamInCompetitionListByTeamId(int teamId);
    
	/**
	 * This method gets map(key - TeamInCompetition, value - is valid all racers from this team for this competition) 
	 * @param teamInCompetitionList - list of registered teams in competition
	 * @return map of valid and invalid teams for competition
	 * @author Ivan Kozub
	 */ 
	public Map<TeamInCompetition, Boolean> isValidTeamInCompetitionMap(List<TeamInCompetition> teamInCompetitionList);
	
	public void deleteTeamInCompetitionByTeamIdAndCompetitionId(int teamId, int competitionId);
    
}
