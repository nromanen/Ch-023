package net.carting.web;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.carting.domain.CarClass;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.CarClassCompetitionResult;
import net.carting.domain.Competition;
import net.carting.domain.Leader;
import net.carting.domain.Qualifying;
import net.carting.domain.Race;
import net.carting.domain.RaceResult;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassCompetitionNumber;
import net.carting.domain.RacerCarClassNumber;
import net.carting.domain.Team;
import net.carting.service.AdminSettingsService;
import net.carting.service.CarClassCompetitionResultService;
import net.carting.service.CarClassCompetitionService;
import net.carting.service.CarClassService;
import net.carting.service.CompetitionService;
import net.carting.service.LeaderService;
import net.carting.service.QualifyingService;
import net.carting.service.RaceService;
import net.carting.service.RacerCarClassCompetitionNumberService;
import net.carting.service.RacerService;
import net.carting.service.TeamInCompetitionService;
import net.carting.service.TeamService;
import net.carting.service.UserService;
import net.carting.util.CompetitionValidator;
import net.carting.util.DateUtil;
import net.carting.util.GlobalData;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/competition")
public class CompetitionController {

    @Autowired
    private CompetitionService competitionService;
    @Autowired
    private RaceService raceService;
    @Autowired
    private TeamService teamService;
    @Autowired
    private CarClassService carClassService;
    @Autowired
    private LeaderService leaderService;
    @Autowired
    private UserService userService;
    @Autowired
    private CarClassCompetitionService carClassCompetitionService;
    @Autowired
    private CarClassCompetitionResultService carClassCompetitionResultService;
    @Autowired
    private RacerCarClassCompetitionNumberService racerCarClassCompetitionNumberService;
    @Autowired
    private RacerService racerService;
    @Autowired
    private TeamInCompetitionService teamInCompetitionService;
    @Autowired
    private AdminSettingsService adminSettingsService;
    @Autowired
    private QualifyingService qualifyingService;

    private static final Logger LOG = LoggerFactory.getLogger(CompetitionController.class);

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ModelAndView competitionPage(Model model, @PathVariable("id") int id) {
        Competition competition = competitionService.getCompetitionById(id);
        Date checkdate = competition.getDateStart();
        List<Racer> racersBirthday = racerService.getBirthdayRacers(checkdate);
        model.addAttribute("competition", competition);
        List<CarClass> carClasses = carClassService.getAllCarClasses();
        List<CarClassCompetition> carClassCompetitions = carClassCompetitionService.getCarClassCompetitionsByCompetitionId(id);
        model.addAttribute("carClassList", competitionService
                .getDifferenceBetweenCarClassesAndCarClassCompetitions(carClasses, carClassCompetitions));
        model.addAttribute("racersBirthday", racersBirthday);
        model.addAttribute("carClassCompetitionList", carClassCompetitions);
        model.addAttribute("pointsByPlacesList", competitionService.getPointsByPlacesList(competition));
        return new ModelAndView("competition");
    }

    @RequestMapping(value = "/list/{year}/{page}", method = RequestMethod.GET)
    public ModelAndView competitionsPage(Model model, @PathVariable("year") String yearString, @PathVariable("page") int page, 
            @RequestParam(value = "competitionsPerPage", required=false, defaultValue = "10") int competitionsPerPage) {
    	if (yearString.equals("all")) {
    	    List<Competition> competitionList = competitionService.getAllCompetitionsByPage(page, competitionsPerPage);
    	    long countOfCompetitions = competitionService.getCountOfCompetitions();
    	    model.addAttribute("competitionList", competitionList);
            model.addAttribute("yearsList", competitionService.getCompetitionsYearsList());
            model.addAttribute("all", yearString);
            model.addAttribute("countOfCompetitions", countOfCompetitions);
            model.addAttribute("competitionsPerPage", competitionsPerPage);
    	} else {
    	    int year;
            try {
                year = Integer.parseInt(yearString);
            } catch (NumberFormatException e) {
                year=0;
            }
            if(!competitionService.getCompetitionsYearsList().contains(year)) {
                year = competitionService.getCompetitionsYearsList().get(0);
            }
			GlobalData.globalYear = year;
            List<Competition> competitionList = competitionService.getCompetitionsByYear(year);
            model.addAttribute("competitionList", competitionList);
            model.addAttribute("yearsList", competitionService.getCompetitionsYearsList());
            model.addAttribute("year", year);
    	}

        return new ModelAndView("competitions");
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public ModelAndView addCompetitionPage(Model model) {
        return new ModelAndView("competition_add_edit");
    }

    @RequestMapping(value = "/addCompetition", method = RequestMethod.POST)
    public
    @ResponseBody
    String addCompetitionAction(
            @ModelAttribute("newCompetition") Competition competition, BindingResult result) {
        CompetitionValidator validator = new CompetitionValidator();
        validator.validate(competition, result);
        if (result.hasErrors()) {
            LOG.trace("Admin failed adding new competition {} (id = {})", competition.getName(), competition.getId());
            return "fail";
        }
        competition.setPointsByPlaces(adminSettingsService.getAdminSettings().getPointsByPlaces());
        competitionService.addCompetition(competition);
        LOG.trace("Admin has added new competition {} (id = {}))", competition.getName(), competition.getId());
        return String.valueOf(competition.getId());
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String deleteCompetitionAction(@RequestBody Map<String, Object> map) {
        Competition competition = competitionService.getCompetitionById(Integer.parseInt(map.get("id").toString()));
        try {
            competitionService.deleteCompetition(competition);
            LOG.trace("Admin has deleted competition {} (id = {})", competition.getName(), competition.getId());
        } catch (Exception e) {
            LOG.trace("Admin trying to delete competition {} (id = {})", competition.getName(), competition.getId());
            return "error";
        }
        return "success";
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public ModelAndView editCompetitionPage(Model model,
                                            @PathVariable("id") int id) {
        Competition competition = competitionService.getCompetitionById(id);

        if (competition.isEnabled()) {
            model.addAttribute("competition", competition);
            return new ModelAndView("competition_add_edit");
        } else {
            return new ModelAndView("redirect:/competition/" + competition.getId());
        }
    }

    @RequestMapping(value = "/editAction", method = RequestMethod.POST)
    public String editCompetitionAction(
            @ModelAttribute("editedCompetition") Competition competition) {
    	
    	competitionService.updateCompetition(competition);
    	List<CarClassCompetition> carClassCompetitions = carClassCompetitionService.getCarClassCompetitionsByCompetitionId(competition.getId());
    	for (CarClassCompetition carClassCompetition : carClassCompetitions) {
        	for (Race race : carClassCompetition.getRaces()) {
            	raceService.setResultTable(raceService.getChessRoll(race), race);
            	carClassCompetitionResultService.recalculateAbsoluteResultsByEditedRace(carClassCompetition, race);
            }
        }
        LOG.trace("Admin has edited competition {} (id = {})", competition.getName(), competition.getId());
        return "redirect:/competition/" + competition.getId();
    }

    @RequestMapping(value = "/{id}/addCarClass", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String addCarClassCompetition(@PathVariable("id") int id,
                                  @RequestBody Map<String, Object> map) {
        Competition competition = competitionService.getCompetitionById(id);
        CarClassCompetition carClassCompetition = new CarClassCompetition();
        carClassCompetition.setCompetition(competition);
        carClassCompetition.setCarClass(carClassService.getCarClassById(Integer.parseInt(map.get("carClassId").toString())));
        carClassCompetition.setFirstRaceTime(DateUtil.getTimeFromString(map.get("firstRaceTime").toString()));
        carClassCompetition.setSecondRaceTime(DateUtil.getTimeFromString(map.get("secondRaceTime").toString()));
        carClassCompetition.setCircleCount(Integer.parseInt(map.get("lapCount").toString()));
        carClassCompetition.setPercentageOffset(Integer.parseInt(map.get("percentageOffset").toString()));
        carClassCompetitionService.addCarClassCompetition(carClassCompetition);
        LOG.trace("Admin has added car class {} to competition with name {} (id = {})", carClassCompetition.getCarClass().getName(), competition.getName(), competition.getId());
        return Integer.toString(carClassCompetition.getId());
    }

    @RequestMapping(value = "/{id}/mandat", method = RequestMethod.GET)
    public String competitionMandatStatementPage(@PathVariable("id") int id,
                                                 Map<String, Object> map) {

        List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumbers = racerCarClassCompetitionNumberService
                .getRacerCarClassCompetitionNumbersByCompetitionId(id);
        List<CarClassCompetition> carClassCompetitions = carClassCompetitionService
                .getCarClassCompetitionsByCompetitionId(id);

        map.put("teamList", competitionService.getTeamsFromRacerCarClassCompetitionNumbers(racerCarClassCompetitionNumbers));
        map.put("racerCarClassCompetitionNumbers", racerCarClassCompetitionNumbers);
        map.put("carClassCompetitions", carClassCompetitions);

        if (racerCarClassCompetitionNumbers.size() > 0) {
            map.put("competition", racerCarClassCompetitionNumbers.get(0)
                    .getCarClassCompetition().getCompetition());
        }

        map.put("formater", new SimpleDateFormat("yyyy-MM-dd"));
        map.put("today", new Timestamp(new Date().getTime()));
        map.put("perentalPermissionYears", adminSettingsService.getAdminSettings().getParentalPermissionYears());

        return "competition_mandat";
    }
    
    @RequestMapping(value = "/{id}/personal", method = RequestMethod.GET)
    public String personalOffsetPage(@PathVariable("id") int id,
                                                 Map<String, Object> map) {
    	List<CarClassCompetition> carClassCompetitions = carClassCompetitionService
                .getCarClassCompetitionsByCompetitionId(id);
    	List<List<List<RaceResult>>> raceResults = new ArrayList<List<List<RaceResult>>>();
    	List<List<CarClassCompetitionResult>> carClassCompetitionResults = new ArrayList<List<CarClassCompetitionResult>>();
    	List<List<Qualifying>> qualifyingResults = new ArrayList<List<Qualifying>>();
    	for (CarClassCompetition carClassCompetition : carClassCompetitions) {
    		raceResults.add(raceService.getRaceResultsByCarClassCompetition(carClassCompetition));
    		carClassCompetitionResults.add(carClassCompetitionResultService.getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition));
    		qualifyingResults.add(qualifyingService.getQualifyingsByCarClassCompetition(carClassCompetition));
    	}
    	map.put("qualifyingLists", qualifyingResults);
    	map.put("carClassCompetitions", carClassCompetitions);
    	map.put("raceResultsLists", raceResults);
    	map.put("absoluteResultsList", carClassCompetitionResults);
    	

        return "competition_personal_offset";
    }

    @RequestMapping(value = "/setEnabled", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String setCompetitionEnabled(@RequestBody Map<String, Object> map) {
        int competitionId = Integer.parseInt(map.get("competitionId").toString());
        boolean enabled = Boolean.parseBoolean(map.get("enabled").toString());
        competitionService.setEnabled(competitionId, enabled);
        LOG.trace("Admin has {} competition (id = {})", (enabled ? "enabled" : "disabled"),  competitionId);
        return "success";
    }

    @RequestMapping(value = "/{id}/unregisterRacer", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String unregisterRacerFromCompetitionAction(
            @RequestBody Map<String, Object> map, @PathVariable("id") int id) {
        int competitonId = id;
        int racerId = Integer.parseInt(map.get("racerId").toString());
        racerCarClassCompetitionNumberService.deleteByCompetitionIdAndRacerId(competitonId, racerId);
        LOG.trace("Admin has unregistered racer(id = {}) from competition (id = {})", racerId, competitonId);
        return "success";
    }

    // team registration view
    @RequestMapping(value = "/chooseCompetition", method = RequestMethod.GET)
    public String chooseCompetition(Map<String, Object> map) {

        String username = userService.getCurrentUserName();
        Leader leader = leaderService.getLeaderByUserName(username);
        if (teamService.isTeamByLeaderId(leader.getId())) {
            map.put("competitionsList", competitionService.getAllEnabledCompetitions());
            return "choose_competition";
        } else {
            return "redirect:/index";
        }
    }

    // team registration view
    /*TODO  Remove HttpServletRequest*/
    @RequestMapping(value = "/teamRegistration", method = RequestMethod.GET)
    public String registrationTeamOnCompetitionView(Map<String, Object> map, @RequestParam(value="competition", required=false) Integer competitionId) {
        if (competitionId != null) {
            String username = userService.getCurrentUserName();
            Leader leader = leaderService.getLeaderByUserName(username);
            if (teamService.isTeamByLeaderId(leader.getId())) {
                Team team = teamService.getTeamByLeader(leader);
                map.put("team", team);
                int teamId = team.getId();
                boolean isTeamInCompetition = teamInCompetitionService
                        .isTeamInCompetition(teamId, competitionId);
                map.put("isTeamInCompetition", isTeamInCompetition);
                Competition competition = competitionService
                        .getCompetitionById(competitionId);
                map.put("competitionName", competition.getName());
                map.put("competitionEnabled", competition.isEnabled());
                List<CarClassCompetition> carClassesByCompetition = carClassCompetitionService
                        .getCarClassCompetitionsByCompetitionId(competitionId);
                List<CarClass> carClassesInCompetitionlist = new ArrayList<CarClass>();
                for (int i = 0; i < carClassesByCompetition.size(); i++) {
                    carClassesInCompetitionlist.add(carClassesByCompetition
                            .get(i).getCarClass());
                }
                map.put("carClassesInCompetitionlist",
                        carClassesInCompetitionlist);
                map.put("carClassesByCompetition", carClassesByCompetition);
            }
            map.put("carClassesCompetition", carClassCompetitionService.getAllCarClassCompetitions()); // ?
            map.put("racerCarClassNumber", new RacerCarClassNumber());
            map.put("competitionId", competitionId);
            return "competition_team_add";
        } else {

            return "redirect:/competition/chooseCompetition";
        }
    }

    // team registration action
    @RequestMapping(value = "/addTeam", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    int registrationTeamOnCompetitionAction(@RequestBody Map<String, Object> formMap) {
        racerCarClassCompetitionNumberService
                .registrationTeamRacersOnCompetition(formMap);
        int competitionId = Integer.parseInt(formMap.get("competitionId")
                .toString());
        return competitionId;
    }
    
    @RequestMapping(value = "/{id}/changePointsByPlaces", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String changePointsByPlaces(@RequestBody Map<String, Object> map, @PathVariable("id") int id) {
    	LOG.debug("Start changePointsByPlaces method");
        Competition competition = competitionService.getCompetitionById(id);
        String pointsByPlaces = map.get("pointsByPlaces").toString();
        competition.setPointsByPlaces(pointsByPlaces);
        competitionService.updateCompetition(competition);
        List<CarClassCompetition> carClassCompetitions = carClassCompetitionService.getCarClassCompetitionsByCompetitionId(competition.getId());
    	for (CarClassCompetition carClassCompetition : carClassCompetitions) {
        	for (Race race : carClassCompetition.getRaces()) {
            	raceService.setResultTable(raceService.getChessRoll(race), race);
            	carClassCompetitionResultService.recalculateAbsoluteResultsByEditedRace(carClassCompetition, race);
            }
        }
    	LOG.debug("End changePointsByPlaces method");
        return "success";
    }
    
    @RequestMapping(value = "/{id}/teamsRanking", method = RequestMethod.GET)
    public String teamRankingPage(@PathVariable("id") int id, Map<String, Object> map) {
        Competition competition = competitionService.getCompetitionById(id);
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        map.put("competitionDate", dateFormat.format(competition.getDateStart()) + " - " + dateFormat.format(competition.getDateEnd()));
        map.put("competition", competition);
        List<Team> teamList = teamInCompetitionService.getTeamsByCompetitionId(id);
        map.put("teamList", teamList);
        List<Integer> teamRes;
        List<Integer> cccRes;
        List<Integer>absoluteRes = new ArrayList<Integer>();
        for (Team team:teamList) {
            teamRes = new ArrayList<Integer>();
            for (CarClassCompetition ccc: competition.getCarClassCompetitions()) {
                cccRes = new ArrayList<Integer>();
                for (CarClassCompetitionResult cccr:carClassCompetitionResultService.getCarClassCompetitionResultsOrderedByPoints(ccc)) {
                    if(cccr.getAbsolutePoints()>0){
                        for(Racer racer:team.getRacers()) {
                            if(racer.equals(cccr.getRacerCarClassCompetitionNumber().getRacer())) {
                                cccRes.add(cccr.getAbsolutePoints());
                            }
                        }
                    }
                }
                if (!cccRes.isEmpty()) {
                    Integer max = cccRes.get(0);
                    if (cccRes.size()>1) {
                        for (Integer i:cccRes) {
                           if (i>max) {
                               max = i;
                           }
                        }
                    }
                    teamRes.add(max);
                }
            }
            Collections.sort(teamRes);
            int absoluteSum = 0;
            if(teamRes.size()>5) {
                for (int i=teamRes.size()-1;i>teamRes.size()-6;i--) {
                    System.out.println(teamRes.get(i));
                    absoluteSum=absoluteSum+teamRes.get(i);
                }
                
            } else {
                for (int i=0;i<teamRes.size();i++) {
                    absoluteSum=absoluteSum+teamRes.get(i);
                }
            }
            absoluteRes.add(absoluteSum);
        }
        map.put("absolutResults", absoluteRes);
        
        return "teams_ranking";
    }

        if (racerCarClassCompetitionNumbers.size() > 0) {
            map.put("competition", racerCarClassCompetitionNumbers.get(0)
                    .getCarClassCompetition().getCompetition());
        }
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        map.put("competitionDate", dateFormat.format(competition.getDateStart()) + " - " + dateFormat.format(competition.getDateEnd()));
        List<Team> teamsList = competitionService.getTeamsFromRacerCarClassCompetitionNumbers(racerCarClassCompetitionNumbers);
        for(int i=0;i<carClassCompetitions.size();i++)
        System.out.println(carClassCompetitionResultService.getCarClassCompetitionResultsByCarClassCompetition(carClassCompetitions.get(i)));
        return "teams_ranking";
    }

}
