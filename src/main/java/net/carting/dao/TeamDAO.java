package net.carting.dao;

import net.carting.domain.Leader;
import net.carting.domain.Team;

import java.util.List;

public interface TeamDAO {

    public List<Team> getAllTeams();

    public Team getTeamById(int id);

    public void addTeam(Team team);

    public void updateTeam(Team team);

    public void deleteTeam(Team team);

    public boolean isSetTeam(String teamName);
    
    public Team getTeamByLeader(Leader leader);
   
    public boolean isTeamByLeaderId(int leaderId);
    
}
