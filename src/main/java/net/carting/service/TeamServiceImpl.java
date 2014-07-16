package net.carting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.carting.domain.Leader;
import net.carting.domain.Team;
import net.carting.dao.TeamDAO;

@Service
public class TeamServiceImpl implements TeamService {

	@Autowired
	private TeamDAO teamDAO;

	@Override
	@Transactional
	public List<Team> getAllTeams() {
		return teamDAO.getAllTeams();
	}

	@Override
	@Transactional
	public Team getTeamById(int id) {
		return teamDAO.getTeamById(id);
	}

	@Override
	@Transactional
	public void addTeam(Team team) {
		teamDAO.addTeam(team);
	}

	@Override
	@Transactional
	public void updateTeam(Team team) {
		teamDAO.updateTeam(team);
	}

	@Override
	@Transactional
	public void deleteTeam(Team team) {
		teamDAO.deleteTeam(team);
	}

	@Transactional
	public boolean isSetTeam(String teamName) {
		return teamDAO.isSetTeam(teamName);
	}

	@Override
	@Transactional
	public Team getTeamByLeader(Leader leader) {
		return teamDAO.getTeamByLeader(leader);
	}

	@Override
	@Transactional
	public boolean isTeamByLeaderId(int leaderId) {
		return teamDAO.isTeamByLeaderId(leaderId);
	}

}
