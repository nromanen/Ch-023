package net.carting.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.CarClassCompetitionResult;
import net.carting.domain.Competition;
import net.carting.domain.Leader;
import net.carting.domain.Race;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassCompetitionNumber;
import net.carting.domain.RacerCarClassNumber;
import net.carting.domain.Team;
import net.carting.service.CarClassCompetitionResultService;
import net.carting.service.CarClassCompetitionService;
import net.carting.service.CarClassService;
import net.carting.service.CompetitionService;
import net.carting.service.LeaderService;
import net.carting.service.RaceService;
import net.carting.service.RacerCarClassCompetitionNumberService;
import net.carting.service.RacerCarClassNumberService;
import net.carting.service.RacerService;
import net.carting.service.TeamInCompetitionService;
import net.carting.service.TeamService;
import net.carting.service.UserService;
import net.carting.util.DateUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/carclass")
public class CarClassCompetitionController {

    // MAX_RACES - max races, const.
    public static final int MAX_RACES = 2;

    @Autowired
    private CarClassCompetitionService carClassCompetitionService;
    @Autowired
    private RacerCarClassCompetitionNumberService racerCarClassCompetitionNumberService;
    @Autowired
    private RaceService raceService;
    @Autowired
    private LeaderService leaderService;
    @Autowired
    private UserService userService;
    @Autowired
    private TeamService teamService;
    @Autowired
    private CarClassService carClassService;
    @Autowired
    private RacerCarClassNumberService racerCarClassNumberService;
    @Autowired
    private RacerService racerService;
    @Autowired
    private CarClassCompetitionResultService carClassCompetitionResultService;
    @Autowired
    private TeamInCompetitionService teamInCompetitionService;
    @Autowired
    private CompetitionService competitionService;

    private static final Logger LOG = LoggerFactory.getLogger(CarClassCompetitionController.class);

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ModelAndView competitionPage(Model model, @PathVariable("id") int id) {

        if (userService.getCurrentAuthority().equals(UserService.ROLE_TEAM_LEADER)) {
            String username = userService.getCurrentUserName();            
            Leader leader = leaderService.getLeaderByUserName(username);
            Team teamByLeader = teamService.getTeamByLeader(leader);
            model.addAttribute("teamByLeader", teamByLeader);
            model.addAttribute("disableRacersToRegistration",
                    carClassCompetitionService.getNotValidRacersToRegistration(id, teamByLeader));
        }

        CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(id);
        model.addAttribute("carClassCompetition", carClassCompetition);

        List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumberList =
                racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersByCarClassCompetitionId(id);

        model.addAttribute("racerCarClassCompetitionNumberList", racerCarClassCompetitionNumberList);
        model.addAttribute("raceResultsLists", raceService.getRaceResultsByCarClassCompetition(carClassCompetition));
        model.addAttribute("chessRollsList", raceService.getChessRollsByCarClassCompetition(carClassCompetition));
        model.addAttribute("raceListSize", raceService.getRacesByCarClassCompetition(carClassCompetition).size());
        model.addAttribute("absoluteResultsList", carClassCompetitionResultService.getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition));
        model.addAttribute("maxRaces", MAX_RACES);
        return new ModelAndView("competition_carclass");
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String deleteCarClassCompetitionAction(@RequestBody Map<String, Object> map) {
        CarClassCompetition carClassCompetition = carClassCompetitionService
                .getCarClassCompetitionById(Integer.parseInt(map.get("id").toString()));
        try {
            carClassCompetitionService.deleteCarClassCompetition(carClassCompetition);
            LOG.trace("Admin has deleted car class {} from competition {} (id = {})", carClassCompetition.getCarClass().getName(),
                    				carClassCompetition.getCompetition().getName(), carClassCompetition.getCompetition().getId());
        } catch (Exception e) {
        	LOG.trace("Admin trying to delete car class {} from competition {} (id = {})", carClassCompetition.getCarClass().getName(),
    				carClassCompetition.getCompetition().getName(), carClassCompetition.getCompetition().getId());
            return "error";
        }
        return "success";
    }

    @RequestMapping(value = "/editAction", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String editCarClassCompetitionAction(@RequestBody Map<String, Object> map) {
        CarClassCompetition carClassCompetition = new CarClassCompetition();
        carClassCompetition.setId(Integer.parseInt(map.get("id").toString()));
        carClassCompetition.setFirstRaceTime(DateUtil.getTimeFromString(map.get("firstRaceTime").toString()));
        carClassCompetition.setSecondRaceTime(DateUtil.getTimeFromString(map.get("secondRaceTime").toString()));
        carClassCompetition.setCircleCount(Integer.parseInt(map.get("circleCount").toString()));
        carClassCompetition.setPercentageOffset(Integer.parseInt(map.get("percentageOffset").toString()));
        carClassCompetitionService.updateCarClassCompetition(carClassCompetition);
        LOG.trace("Admin has edited car class competition (id = {})", carClassCompetition.getId());
        return "success";
    }

    @RequestMapping(value = "/getRacersCountById", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    int getRacersCountByIdAction(@RequestBody Map<String, Object> map) {
        int id = Integer.parseInt(map.get("id").toString());
        return racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersCountByCarClassCompetitionId(id);
    }

    @RequestMapping(value = "/{id}/unregisterRacer", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String unregisterRacerFromCarClassCompetitionAction(@RequestBody Map<String, Object> map, @PathVariable("id") int id) {
        int carClassCompetitionId = id;
        int racerId = Integer.parseInt(map.get("racerId").toString());
        String username = userService.getCurrentUserName();
        Competition competition = carClassCompetitionService.getCarClassCompetitionById(carClassCompetitionId).getCompetition();
        Team team = racerService.getRacerById(racerId).getTeam();
        CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(carClassCompetitionId);

        try {
            racerCarClassCompetitionNumberService.deleteByCarClassCompetitionIdAndRacerId(carClassCompetitionId, racerId);

            LOG.trace("{} has unregistered racer(id = {}) from competition {} (id = {}) from car class {} (id = {})", username, racerId,
                    competition.getName(), competition.getId(),
                    carClassCompetition.getCarClass().getName(), carClassCompetitionId);

            //if this racer was last from his team in this competition
            //then unregister his team from this competition
            if (racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersByCompetitionIdAndTeamId(
                    competition.getId(), team.getId()).size() == 0) {
                teamInCompetitionService.deleteTeamInCompetitionByTeamIdAndCompetitionId(team.getId(), competition.getId());

                LOG.trace("{} has unregistered from competition {} (id = {}) because {} has unregistered last racer from his team in this competition",team.getName(),
                        competition.getName(), competition.getId(), username);
            }

        } catch (Exception e) {
            e.printStackTrace();
            LOG.trace("{} trying to unregister racer(id = {}) from competition {} (id = {}) from car class {} (id = {})", username, racerId,
                    competition.getName(), competition.getId(),
                    carClassCompetition.getCarClass().getName(), carClassCompetitionId);
            return "error";
        }
        return "success";
    }

    @RequestMapping(value = "/getRacerNumber", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    int getRacerNumberAction(@RequestBody Map<String, Object> map) {
        int carClassId = Integer.parseInt(map.get("carClassId").toString());
        int racerId = Integer.parseInt(map.get("racerId").toString());
        RacerCarClassNumber racerCarClassNumber = racerCarClassNumberService.getRacerCarClassNumberByCarClassIdAndRacer(carClassId, racerId);
        return racerCarClassNumber.getNumber();
    }

    @RequestMapping(value = "/{id}/registerRacer", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String registerRacerToCarClassCompetitionAction(@RequestBody Map<String, Object> map, @PathVariable("id") int id) {
        try {
            int carClassCompetitionId = id;
            int racerId = Integer.parseInt(map.get("racerId").toString());
            int number = Integer.parseInt(map.get("number").toString());
            RacerCarClassCompetitionNumber racerCarClassCompetitionNumber = new RacerCarClassCompetitionNumber();
            CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(carClassCompetitionId);
            racerCarClassCompetitionNumber.setCarClassCompetition(carClassCompetition);
            Racer racer = racerService.getRacerById(racerId);
            racerCarClassCompetitionNumber.setRacer(racer);
            racerCarClassCompetitionNumber.setNumberInCompetition(number);
            racerCarClassCompetitionNumberService.addRacerCarClassCompetitionNumber(racerCarClassCompetitionNumber);

            String username = userService.getCurrentUserName();
            Competition competition = carClassCompetition.getCompetition();
            LOG.trace("{} has registered racer {} {} (id = {}) with number {} to competition {} (id = {}) to car class {} (id = {})", 
            		username, racer.getFirstName(), racer.getLastName(), racerId, number, competition.getName(),
            		competition.getId(), carClassCompetition.getCarClass().getName(), carClassCompetitionId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    @RequestMapping(value = "/{id}/addResults")
    public String addRacePage(Map<String, Object> map, @PathVariable("id") int id) {
        try {

            map.put("race", new Race());
            map.put("carClassCompetition", carClassCompetitionService.getCarClassCompetitionById(id));
            map.put("membersCount", racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersCountByCarClassCompetitionId(id));
            map.put("validNumbers", raceService.getNumbersArrayByCarClassCompetitionId(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "competition_carclass_results_add_edit";
    }

    @RequestMapping(value = "/{id}/addRace", method = RequestMethod.POST)
    public String addRace(@ModelAttribute("race") Race race,
                          Map<String, Object> map, @PathVariable("id") int id) {
        CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(id);
        race.setCarClassCompetition(carClassCompetition);
        race.setCarClass(carClassCompetition.getCarClass());
        raceService.setRaceNumber(carClassCompetition, race);
        raceService.addRace(race);
        raceService.setResultTable(raceService.getChessRoll(race), race);
        carClassCompetitionResultService.setAbsoluteResults(carClassCompetition, race);
        editRace(race, map, id, race.getRaceNumber(), String.valueOf(race.getNumberOfLaps()));
        LOG.trace("Admin has added race with id={} race number {} in car class competition {} in competition {}", race.getId(), race.getRaceNumber(),
        		carClassCompetition.getCarClass().getName(), carClassCompetition.getCompetition().getName());
        return "redirect:/carclass/" + id;
    }

    @RequestMapping(value = "/{id}/race/{raceNumber}/edit")
    public String editRacePage(Map<String, Object> map, @PathVariable("id") int id, @PathVariable("raceNumber") int raceNumber) {
        map.put("race", raceService.getRaceByNumberAndCarClassCompetition(raceNumber, carClassCompetitionService.getCarClassCompetitionById(id)));
        map.put("carClassCompetition", carClassCompetitionService.getCarClassCompetitionById(id));
        map.put("membersCount", racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersCountByCarClassCompetitionId(id));
        map.put("validNumbers", raceService.getNumbersArrayByCarClassCompetitionId(id));
        map.put("edit", true);

        return "competition_carclass_results_add_edit";
    }

    @RequestMapping(value = "/{id}/race/{raceNumber}/editRace", method = RequestMethod.POST)
    public String editRace(@ModelAttribute("race") Race race,
                           Map<String, Object> map, @PathVariable("id") int id,
                           @PathVariable("raceNumber") int raceNumber,
                           @RequestParam("numberOfLaps") String lapsNumber) {
        try {
            int laps = Integer.parseInt(lapsNumber);
            CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(id);
            race.setCarClassCompetition(carClassCompetition);
            race.setId(raceService.getRaceByNumberAndCarClassCompetition(raceNumber, carClassCompetition).getId());
            race.setCarClass(carClassCompetition.getCarClass());
            race.setRaceNumber(raceNumber);
            raceService.updateRace(race);
            raceService.setResultTable(raceService.getChessRoll(race), race);
            carClassCompetitionResultService.recalculateAbsoluteResultsByEditedRace(carClassCompetition, race);

            LOG.trace("Admin has edited race with id={} race number {} in car class competition {} in competition {}", race.getId(), raceNumber,
            		carClassCompetition.getCarClass().getName(), carClassCompetition.getCompetition().getName());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/carclass/" + id;
    }

    @RequestMapping(value = "/{id}/editSummaryResults")
    public String editSummaryResultsPage(Map<String, Object> map, @PathVariable("id") int id) {
        CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(id);
        map.put("absoluteResultsList", carClassCompetitionResultService.getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition));
        map.put("carClassCompetition", carClassCompetition);
        return "competetition_carclass_absoluteresults_edit";

    }

    @RequestMapping(value = "/{id}/editResults", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String editSummaryResult(@RequestBody Map<String, Object> map, @PathVariable("id") int id) {
        ArrayList<HashMap<String, String>> mapsList = (ArrayList<HashMap<String, String>>) map.get("jsonObject");
        CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(id);
        LOG.trace("Admin has edited  summary results in car class competition {}", carClassCompetition.getCarClass().getName());
        for (HashMap<String, String> idAndPoint : mapsList) {
            CarClassCompetitionResult result = carClassCompetitionResultService.getCarClassCompetitionResultById(Integer.parseInt(idAndPoint.get("id")));
            result.setAbsolutePoints(Integer.parseInt(idAndPoint.get("resultPoint")));
            carClassCompetitionResultService.updateCarClassCompetitionResult(result);
            LOG.trace("Result with id={} has been changed to value {}", Integer.parseInt(idAndPoint.get("id")), Integer.parseInt(idAndPoint.get("resultPoint")));
        }
        carClassCompetitionResultService.recalculateAbsoluteResults(carClassCompetition);
        LOG.trace("Result table has been recalculated ");
        return "success";

    }

    @RequestMapping(value = "/editConcreteResultAction", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String editConcreteResultAction(@RequestBody Map<String, Object> map) {
        CarClassCompetitionResult carClassCompetitionResult = carClassCompetitionResultService.getCarClassCompetitionResultById(Integer.parseInt(map.get("id").toString()));

        carClassCompetitionResult.setAbsolutePoints(carClassCompetitionResult.getAbsolutePoints() + Integer.parseInt(map.get("fineValue").toString()));
        carClassCompetitionResult.setComment(map.get("comment").toString());
        LOG.trace("Result of {} has been changed by {}", carClassCompetitionResult.getRacerCarClassCompetitionNumber().getRacer().getLastName(),
        												carClassCompetitionResult.getComment());
        carClassCompetitionResultService.updateCarClassCompetitionResult(carClassCompetitionResult);
        carClassCompetitionResultService.recalculateAbsoluteResults(carClassCompetitionResult.getRacerCarClassCompetitionNumber().getCarClassCompetition());
        LOG.trace("Result table has been recalculated ");
        return "success";
    }
    
}
