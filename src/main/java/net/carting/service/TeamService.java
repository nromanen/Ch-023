package net.carting.service;

import java.util.List;

import net.carting.domain.Leader;
import net.carting.domain.Team;

public interface TeamService {

	public List<Team> getAllTeams();

	public Team getTeamById(int id);

	public void addTeam(Team team);

	public void updateTeam(Team team);

	public void deleteTeam(Team team);

	public Team getTeamByLeader(Leader leader);

	public boolean isSetTeam(String team_name);

	public boolean isTeamByLeaderId(int leaderId);	

}
