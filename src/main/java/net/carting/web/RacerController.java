package net.carting.web;

import net.carting.domain.*;
import net.carting.service.*;
import net.carting.util.DateUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping(value = "/racer")
public class RacerController {

    public static final String ROLE_TEAM_LEADER = "ROLE_TEAM_LEADER";
    public static final String ROLE_ADMIN = "ROLE_ADMIN";

    private static final ThreadLocal<SimpleDateFormat> formatter = new ThreadLocal<SimpleDateFormat>() {
        @Override
        protected SimpleDateFormat initialValue() {
            return new SimpleDateFormat("yyyy-MM-dd");
        }
    };

    @Autowired
    private RacerService racerService;
    @Autowired
    private TeamService teamService;
    @Autowired
    private CarClassService carClassService;
    @Autowired
    private CarClassCompetitionService carClassCompetitionService;
    @Autowired
    private RacerCarClassNumberService racerCarClassNumberService;
    @Autowired
    private RacerCarClassCompetitionNumberService racerCarClassCompetitionNumberService;
    @Autowired
    private LeaderService leaderService;
    @Autowired
    private UserService userService;

    private static final Logger LOG = Logger.getLogger(RacerController.class);

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String racerPage(Map<String, Object> map, @PathVariable("id") int id) {

        String username = userService.getCurrentUserName();
        String authority = userService.getCurrentAuthority();

        if (authority.equals(ROLE_TEAM_LEADER)) {        	
        	Leader leader = leaderService.getLeaderByUserName(username);
	        Team team = teamService.getTeamByLeader(leader);
	        Racer racer = racerService.getRacerById(id);
	        if (team.getId() != racer.getTeam().getId()) {
	        	return "error_403";
	        }
	        
	        map.put("authority", authority);
	        map.put("racer", racerService.getRacerById(id));	        
	        map.put("team", team);
        } else if (authority.equals(ROLE_ADMIN)) {
        	Racer racer = racerService.getRacerById(id);
        	Team team = teamService.getTeamById(racer.getTeam().getId());
        	map.put("authority", authority);
	        map.put("racer", racerService.getRacerById(id));
	        map.put("team", team);
        }

        return "racer";
    }

    // edit racer by id (view)
    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String editRacerPage(Map<String, Object> map,
                                @PathVariable("id") int id) {
    	
    	String authority = userService.getCurrentAuthority();
    	
        if (authority.equals(ROLE_TEAM_LEADER) || authority.equals(ROLE_ADMIN)) {
            String username = userService.getCurrentUserName();
            Racer racer = racerService.getRacerById(id);
            Team team;
            if (authority.equals(ROLE_TEAM_LEADER)) {
            	Leader leader = leaderService.getLeaderByUserName(username);
            	team = teamService.getTeamByLeader(leader);
            } else {
            	team = teamService.getTeamById(racer.getTeam().getId());
            }
            
            map.put("team", team);
            if (team.getId() == racer.getTeam().getId()) {
                String carClassIds = "";
                String carClassNumbers = "";
                String carClassView = "";

                int i = 0;
                for (RacerCarClassNumber racerCarClassNumber : racer
                        .getCarClassNumbers()) {
                    if (i == 0) {
                        carClassIds += (racerCarClassNumber.getCarClass()
                                .getId());
                        carClassNumbers += (racerCarClassNumber.getNumber());
                        carClassView += (racerCarClassNumber.getCarClass()
                                .getName()
                                + "(#"
                                + racerCarClassNumber.getNumber() + ")");
                        i++;
                    } else {
                        carClassIds += (", " + racerCarClassNumber
                                .getCarClass().getId());
                        carClassNumbers += (", " + racerCarClassNumber
                                .getNumber());
                        carClassView += (", "
                                + racerCarClassNumber.getCarClass().getName()
                                + "(#" + racerCarClassNumber.getNumber() + ")");
                    }
                }
                map.put("racer", racer);
                map.put("carClassIds", carClassIds);
                map.put("carClassNames", carClassNumbers);
                map.put("carClassView", carClassView);
                map.put("carClass", new CarClass());
                map.put("carClassList", carClassService.getAllCarClasses());
                map.put("dateOfBirth", formatter.get().format(racer.getBirthday()));

                return "racer_edit";
            } else {
                return "error_403";
            }

        } else {
            return "error_403";
        }
    }

    // edit racer action
    @RequestMapping(value = "/confirmEdit", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    int editRacerAction(@RequestBody Map<String, Object> racerMap) {
        Racer racer = new Racer();
        racer.setId(Integer.parseInt(racerMap.get("id").toString()));
        racer.setFirstName(racerMap.get("firstName").toString());
        racer.setLastName(racerMap.get("lastName").toString());
        racer.setBirthday(DateUtil.getDateFromString(racerMap.get("birthday").toString()));
        racer.setDocument(racerMap.get("document").toString());
        racer.setAddress(racerMap.get("address").toString());
        racer.setAddress(racerMap.get("address").toString());
        racer.setSportsCategory(Integer.parseInt(racerMap.get("sportCategory")
                .toString()));
        racer.setRegistrationDate(racerService.getRacerById(
                Integer.parseInt(racerMap.get("id").toString()))
                .getRegistrationDate());

        Team team = teamService.getTeamById(Integer.parseInt(racerMap.get(
                "team").toString()));
        racer.setTeam(team);

        racerService.updateRacer(racer);

        String username = userService.getCurrentUserName();
        LOG.info(String.format("%s had edited racer %s %s (id = %s)", username,
                racer.getFirstName(), racer.getLastName(), racer.getId()));

        return racer.getId();
    }

    // add racer (view)
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addRacerPage(Map<String, Object> map) {
        Leader leader = leaderService.getLeaderByUserName(userService.getCurrentUserName());
        Team team = teamService.getTeamByLeader(leader);
        map.put("team", team);
        map.put("carClass", new CarClass());
        map.put("carClassList", carClassService.getAllCarClasses());
        return "racer_add";
    }

    // add racer action
    @RequestMapping(value = "/addRacer", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    int addRacerAction(@RequestBody Map<String, Object> racerMap) {

        Racer racer = new Racer();
        racer.setFirstName(racerMap.get("firstName").toString());
        racer.setLastName(racerMap.get("lastName").toString());
        racer.setBirthday(DateUtil.getDateFromString(racerMap.get("birthday").toString()));
        racer.setDocument(racerMap.get("document").toString());
        racer.setAddress(racerMap.get("address").toString());
        racer.setAddress(racerMap.get("address").toString());
        racer.setSportsCategory(Integer.parseInt(racerMap.get("sportCategory").toString()));
        racer.setRegistrationDate(new Date());
        racer.setEnabled(true);

        Team team = teamService.getTeamById(Integer.parseInt(racerMap.get("team").toString()));
        racer.setTeam(team);

        // parsing car classes numbers string
        String carClassesStr = racerMap.get("carClasses").toString();
        String racerCarClassNumbersStr = racerMap.get("carClassNumbers")
                .toString();
        Set<RacerCarClassNumber> racerCarClassNumbers = racerService.parseCarClasses(
                carClassesStr, racerCarClassNumbersStr, racer);
        // ------------------------------------------------------------
        racerService.addRacer(racer);

        // add Racer CarClass Numbers
        Iterator<RacerCarClassNumber> it = racerCarClassNumbers.iterator();
        while (it.hasNext()) {
            racerCarClassNumberService.addRacerCarClassNumber((RacerCarClassNumber) it.next());
        }
        // --------------------------------------

        String username = userService.getCurrentUserName();
        LOG.info(String.format("%s had added racer %s %s to team %s (id = %s)",
                username, racer.getFirstName(), racer.getLastName(), racer
                        .getTeam().getName(), racer.getTeam().getId()));

        return racer.getId();
    }

    @RequestMapping(value = "/isSetNumberForCarClass", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    boolean isSetNumberForCarClass(@RequestBody Map<String, Object> map) {
        int carClass = Integer.parseInt(map.get("carClass").toString());
        int number = Integer.parseInt(map.get("number").toString());
        return racerCarClassNumberService
                .isSetRacerCarClassNumberByCarClassIdAndNumber(carClass, number);
    }

    @RequestMapping(value = "/getOccupiedDefaultNumbersForCarClass",
            method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String getOccupiedDefaultNumbersForCarClassAction(@RequestBody Map<String, Object> map) {
        int carClassId = Integer.parseInt(map.get("carClassId").toString());
        try {
            return racerCarClassNumberService.getNumbersByCarClassId(carClassId, ",");
        } catch (Exception e) {
            return "error";
        }
    }

    @RequestMapping(value = "/isSetCarClass", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    boolean isSetCarClass(@RequestBody Map<String, Object> map) {
        int carClassId = Integer.parseInt(map.get("carClassId").toString());
        int racerId = Integer.parseInt(map.get("racerId").toString());
        return racerCarClassNumberService.isSetCarClassByCarClassIdAndRacerId(
                carClassId, racerId);
    }

    @RequestMapping(value = "/addRacerCarClassNumber", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String addRacerCarClassNumber(@RequestBody Map<String, Object> map) {
        int racerId = Integer.parseInt(map.get("racerId").toString());
        Racer racer = racerService.getRacerById(racerId);
        int carClassId = Integer.parseInt(map.get("carClassId").toString());
        CarClass carClass = carClassService.getCarClassById(carClassId);
        int number = Integer.parseInt(map.get("number").toString());
        RacerCarClassNumber racerCarClassNumber = new RacerCarClassNumber(
                racer, carClass, number);
        racerCarClassNumberService.addRacerCarClassNumber(racerCarClassNumber);

        String username = userService.getCurrentUserName();
        LOG.info(username + " has added car class" + carClass.getName() + "» with #" + number
                + " to racer " + racer.getFirstName() + " " + racer.getLastName() + "(id = " + racerId + ")");

        return "success";
    }

    @RequestMapping(value = "/updateRacerCarClassNumbers", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String updateRacerCarClassNumbers(@RequestBody Map<String, Object> map) {
        int racerId = Integer.parseInt(map.get("racerId").toString());
        Racer racer = racerService.getRacerById(racerId);
        String updatedRacerCarClassNumbersStr = map.get(
                "updatedRacerCarClassNumbers").toString();
        Set<RacerCarClassNumber> racerCarClassNumbers = racerService.parseUpdatedRacerCarClassNumbers(
                updatedRacerCarClassNumbersStr, racer);
        Iterator<RacerCarClassNumber> it = racerCarClassNumbers.iterator();
        while (it.hasNext()) {
            racerCarClassNumberService
                    .updateRacerCarClassNumber((RacerCarClassNumber) it.next());
        }
        return "success";
    }

    @RequestMapping(value = "/deleteRacerCarClassNumbers", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String deleteRacerCarClassNumbers(@RequestBody Map<String, Object> map) {
        int racerId = Integer.parseInt(map.get("racerId").toString());
        Racer racer = racerService.getRacerById(racerId);
        for (RacerCarClassNumber racerCarClassNumber : racer.getCarClassNumbers()) {
            int carClassId = racerCarClassNumber.getCarClass().getId();
            List<CarClassCompetition> carClassCompetitions = carClassCompetitionService.getCarClassCompetitionsByCarClassId(carClassId);
            for (CarClassCompetition carClassCompetition : carClassCompetitions) {
                racerCarClassCompetitionNumberService.deleteByCarClassCompetitionIdAndRacerId(carClassCompetition.getId(), racerId);
            }
            racerCarClassNumberService.deleteRacerCarClassNumber(racerCarClassNumber);
        }

        return "success";
    }

    @RequestMapping(value = "/deleteChosenRacerCarClassNumbers", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String deleteChosenRacerCarClassNumbers(@RequestBody Map<String, Object> map) {
        String racerCarClassNumbersIdsStr = map.get("racerCarClassNumbersIds")
                .toString();
        String[] racerCarClassNumbersIdsParts = racerCarClassNumbersIdsStr
                .split(",");
        for (int i = 0; i < racerCarClassNumbersIdsParts.length; i++) {
            RacerCarClassNumber racerCarClassNumber = racerCarClassNumberService
                    .getRacerCarClassNumberById(Integer
                            .parseInt(racerCarClassNumbersIdsParts[i].trim()));
            racerCarClassNumberService.deleteRacerCarClassNumber(racerCarClassNumber);
        }

        return "success";
    }

    @RequestMapping(value = "/isSetRacer", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    boolean isSetRacer(@RequestBody Map<String, Object> map) {
        String firstName = map.get("firstName").toString();
        String lastName = map.get("lastName").toString();
        Date birthday = DateUtil.getDateFromString(map.get("birthday").toString());
        return racerService.isSetRacer(firstName, lastName, birthday);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String deleteRacer(@RequestBody Map<String, Object> map) {
        Racer racer = racerService.getRacerById(Integer.parseInt(map.get("id")
                .toString()));
        racerService.deleteRacer(racer);

        String username = userService.getCurrentUserName();
        LOG.info(username + " has deleted racer "
                + racer.getFirstName() + " " + racer.getLastName() + "(id = " + racer.getId() + ")");

        return "success";
    }

    @RequestMapping(value = "/setEnabled", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String setRacerEnabled(@RequestBody Map<String, Object> map) {
        Racer racer = racerService.getRacerById(Integer.parseInt(map.get("racerId").toString()));
        boolean enabled = Boolean.parseBoolean(map.get("enabled").toString());
        racer.setEnabled(enabled);
        racerService.updateRacer(racer);

        String username = userService.getCurrentUserName();
        LOG.info(username + " has " + (enabled ? "enabled" : "disabled") + " racer "
                + racer.getFirstName() + " " + racer.getLastName() + "(id = " + racer.getId() + ")");

        return "success";
    }
}
