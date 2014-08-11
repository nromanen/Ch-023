package net.carting.service;

import net.carting.dao.TeamDAO;
import net.carting.domain.Leader;
import net.carting.domain.Team;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;

import java.util.ArrayList;
import java.util.List;

import static junit.framework.Assert.*;
import static org.mockito.Matchers.anyString;
import static org.mockito.Mockito.*;

/**
 * Carting
 * Created by manson on 8/4/14.
 */
@RunWith(MockitoJUnitRunner.class)
public class TeamServiceTest {

    @InjectMocks
    TeamServiceImpl teamServiceImpl;

    @Mock
    TeamDAO teamDAO;

    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testAddTeam() {
        Team team = new Team();
        teamServiceImpl.addTeam(team);
        teamServiceImpl.addTeam(team);
        teamServiceImpl.addTeam(team);
        verify(teamDAO, times(3)).addTeam(team);
        verify(teamDAO, atLeast(2)).addTeam(team);
        verify(teamDAO, never()).deleteTeam(team);
    }

    @Test
    public void testGetAllTeams() {
        List<Team> teamList = new ArrayList<Team>();
        teamList.add(new Team());
        teamList.add(new Team());
        when(teamDAO.getAllTeams()).thenReturn(teamList);
        assertEquals("Expected 2 teams", 2, teamServiceImpl.getAllTeams().size());
    }

    @Test
    public void testGetTeamById() {
        Team team1 = new Team(1, "name", new Leader());
        Team team2 = new Team(5, "name 2", new Leader());
        when(teamDAO.getTeamById(0)).thenReturn(new Team(1, "name", new Leader()));
        when(teamDAO.getTeamById(1)).thenReturn(new Team(5, "name 2", new Leader()));
        assertTrue(teamDAO.getTeamById(0).equals(team1));
        assertFalse(teamDAO.getTeamById(0).equals(team2));
    }

    @Test
    public void testIsSetTeam() {
        when(teamDAO.isSetTeam("name")).thenReturn(true);
        assertTrue(teamDAO.isSetTeam("name"));
        assertFalse(teamDAO.isSetTeam("namfde"));
        // cause "namfde" is undefined && isSetTeam() will return default value for boolean == false
        when(teamDAO.isSetTeam(anyString())).thenReturn(false);
        // always returns false
        assertFalse(teamDAO.isSetTeam("name"));
        assertFalse(teamDAO.isSetTeam(null));
        when(teamDAO.isSetTeam(anyString())).thenReturn(true);
        assertTrue(teamDAO.isSetTeam(null));
    }

    @Test
    public void testIsTeamByLeaderId() {
        when(teamDAO.isTeamByLeaderId(8)).thenReturn(true);
        assertTrue(teamDAO.isTeamByLeaderId(8));
        assertFalse(teamDAO.isTeamByLeaderId(5));

        when(teamDAO.isTeamByLeaderId(anyInt())).thenReturn(false);
        assertFalse(teamDAO.isTeamByLeaderId(0));
        assertFalse(teamDAO.isTeamByLeaderId(1));

        when(teamDAO.isTeamByLeaderId(anyInt())).thenReturn(true);
        assertTrue(teamDAO.isTeamByLeaderId(5));
        assertTrue(teamDAO.isTeamByLeaderId(2));
    }

    @Test
    public void testDeleteTeam() {
        Team team = new Team();
        teamServiceImpl.deleteTeam(team);
        teamServiceImpl.deleteTeam(team);
        teamServiceImpl.deleteTeam(team);
        verify(teamDAO, times(3)).deleteTeam(team);
        verify(teamDAO, atLeast(2)).deleteTeam(team);
        verify(teamDAO, never()).addTeam(team);
    }

    @Test
    public void testUpdateTeam() {
        Team team = new Team();
        team.setName("teamName");
        teamServiceImpl.updateTeam(team);
        verify(teamDAO, atLeastOnce()).updateTeam(team);
    }

    @Test
    public void test() {
        Team team = new Team();
        team.setName("4");
        Leader lead = new Leader();
        lead.setId(4);

        Team team1 = new Team();
        team1.setName("43");
        Leader leader = new Leader();
        leader.setId(43);

        when(teamServiceImpl.getTeamByLeader(leader)).thenReturn(team1);
        when(teamServiceImpl.getTeamByLeader(lead)).thenReturn(team);
        assertFalse(teamDAO.getTeamByLeader(lead).equals(team1));
        assertTrue(teamDAO.getTeamByLeader(leader).equals(team));

        when(teamServiceImpl.getTeamByLeader(any(Leader.class))).thenReturn(team);
        assertTrue(teamDAO.getTeamByLeader(leader).equals(team));
        assertTrue(teamDAO.getTeamByLeader(lead).equals(team));
        assertTrue(teamDAO.getTeamByLeader(new Leader()).equals(team));
    }

}
