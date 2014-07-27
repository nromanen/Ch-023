package net.carting.dao;

import net.carting.domain.TeamInCompetition;

import java.util.List;

public interface TeamInCompetitionDAO {

    public boolean isTeamInCompetition(int teamId, int competitionId);

    public void addTeamInCompetition(TeamInCompetition teamInCompetition);

    public void deleteTeamInCompetition(TeamInCompetition teamInCompetition);

    public List<TeamInCompetition> getTeamInCompetitionListByTeamId(int teamId);

    public void deleteTeamInCompetitionByTeamIdAndCompetitionId(int teamId, int competitionId);

}
