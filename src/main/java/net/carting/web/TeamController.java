package net.carting.web;

import net.carting.domain.Leader;
import net.carting.domain.Team;
import net.carting.domain.TeamInCompetition;
import net.carting.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/team")
public class TeamController {

    @Autowired
    private TeamService teamService;
    @Autowired
    private LeaderService leaderService;
    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    //private AuthorityService authorityService;
    @Autowired
    private TeamInCompetitionService teamInCompetitionService;
    @Autowired
    private DocumentService documentService;

    // racer list == team list
    @RequestMapping("/") 
    public String root() {
        return "racer_list";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String teamsListPage(Map<String, Object> map) {
        map.put("teamList", teamService.getAllTeams());
        return "teams";
    }

    // view team by id
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String teamPage(Map<String, Object> map, @PathVariable("id") int id) {

        String username = userService.getCurrentUserName();
        Team team = teamService.getTeamById(id);
        map.put("needTeam", team);
        List<TeamInCompetition> teamInCompetitionList = teamInCompetitionService
                .getTeamInCompetitionListByTeamId(id);
        Map<TeamInCompetition, Boolean> isValidTeamInCompetitionMap = teamInCompetitionService
                .isValidTeamInCompetitionMap(teamInCompetitionList);
        map.put("isValidTeamInCompetitionMap", isValidTeamInCompetitionMap);
        map.put("username", username);
        map.put("authority", userService.getCurrentAuthority());
        return "team";
    }

    // edit team by id
    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String editTeamPageString(Map<String, Object> map,
                                     @PathVariable("id") int id) {
        String username = userService.getCurrentUserName();
        Leader leader = leaderService.getLeaderByUserName(username);
        if (teamService.isTeamByLeaderId(leader.getId())) {
            Team teamByLeader = teamService.getTeamByLeader(leader);
            Team team = teamService.getTeamById(id);
            if (teamByLeader.getId() == team.getId()) {

                map.put("team", team);
                String birthDate = team.getLeader().getBirthday().toString();
                if (birthDate
                        .matches("[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])( 00:00:00.0)")) {
                    birthDate = birthDate.substring(0, 10);
                }
                map.put("birthDate", birthDate);
                map.put("username", username);
                return "team_edit";
            } else {
                return "redirect:/error403/";
            }
        } else {
            return "redirect:/add";
        }

    }

    // edit team worker
    @RequestMapping(value = "/editTeam", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    int editTeam(@RequestBody Map<String, Object> formMap) {
        String username = userService.getCurrentUserName();
        Leader leader = leaderService.getLeaderByUserName(username);
        Team team = teamService.getTeamByLeader(leader);
        team.setName(formMap.get("team_name").toString());
        team.setAddress(formMap.get("address").toString());
        team.setLicense(formMap.get("license").toString());
        teamService.updateTeam(team);
        return team.getId();
    }

    // add team page
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addTeamPage(Map<String, Object> map) {

        Leader leader = leaderService.getLeaderByUserName(userService
                .getCurrentUserName());
        if (teamService.isTeamByLeaderId(leader.getId()) == false) {
            map.put("username", userService.getCurrentUserName());
            map.put("authority", userService.getCurrentAuthority());
            return "team_add";
        }
        return "index";
    }

    // add team worker
    @RequestMapping(value = "/addTeam", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    int addTeam(@RequestBody Map<String, Object> formMap) {

        Leader leader = leaderService.getLeaderByUserName(userService
                .getCurrentUserName());
        Team team = new Team();
        team.setLeader(leader);
        team.setName(formMap.get("team_name").toString());
        team.setAddress(formMap.get("address").toString());
        team.setLicense(formMap.get("license").toString());
        teamService.addTeam(team);
        return team.getId();

    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String deleteTeam(@RequestBody Map<String, Object> map) {
        String username = userService.getCurrentUserName();
        Leader leader = leaderService.getLeaderByUserName(username);
        Team teamByLeader = teamService.getTeamByLeader(leader);
        Team team = teamService.getTeamById(Integer.parseInt(map.get("id")
                .toString()));
        if (teamByLeader.getId() == team.getId()) {
            teamService.deleteTeam(team);
            return "success";
        } else {
            return "redirect:/error403/";
        }
    }

    @RequestMapping(value = "/isSetTeam", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    boolean isSetTeam(@RequestBody Map<String, Object> map) {
        String team_name = map.get("team_name").toString();
        return teamService.isSetTeam(team_name);
    }

}