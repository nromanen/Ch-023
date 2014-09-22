package net.carting.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import net.carting.domain.CarClass;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Leader;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassNumber;
import net.carting.domain.Team;
import net.carting.service.CarClassCompetitionService;
import net.carting.service.CarClassService;
import net.carting.service.LeaderService;
import net.carting.service.RacerCarClassCompetitionNumberService;
import net.carting.service.RacerCarClassNumberService;
import net.carting.service.RacerService;
import net.carting.service.TeamService;
import net.carting.service.UserService;
import net.carting.util.DateUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping(value = "/racer")
public class RacerController {

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

    private static final Logger LOG = LoggerFactory.getLogger(RacerController.class);

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String racerPage(Map<String, Object> map, @PathVariable("id") int id) {

        String username = userService.getCurrentUserName();
        String authority = userService.getCurrentAuthority();

        if (authority.equals(UserService.ROLE_TEAM_LEADER)) {
            Leader leader = leaderService.getLeaderByUserName(username);
            Team team = teamService.getTeamByLeader(leader);
            Racer racer = racerService.getRacerById(id);
            if (team.getId() != racer.getTeam().getId()) {
                return "error_403";
            }

            map.put("authority", authority);
            map.put("racer", racerService.getRacerById(id));
            map.put("team", team);
        } else if (authority.equals(UserService.ROLE_ADMIN)) {
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
    public String editRacerPage(Map<String, Object> map, @PathVariable("id") int id) {

        String authority = userService.getCurrentAuthority();

        if (authority.equals(UserService.ROLE_TEAM_LEADER) || authority.equals(UserService.ROLE_ADMIN)) {
            String username = userService.getCurrentUserName();
            Racer racer = racerService.getRacerById(id);
            Team team;
            if (authority.equals(UserService.ROLE_TEAM_LEADER)) {
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
    	LOG.debug("Start editRacerAction method");
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
        LOG.trace("{} had edited racer {} {} (id = {})", username,
                racer.getFirstName(), racer.getLastName(), racer.getId());
        LOG.debug("End editRacerAction method");
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
    Integer addRacerAction(@RequestBody Map<String, Object> racerMap) {
    	
    	LOG.debug("Start addRacerAction method");
        Racer racer = new Racer();
        racer.setFirstName(racerMap.get("firstName").toString());
        racer.setLastName(racerMap.get("lastName").toString());
        racer.setBirthday(DateUtil.getDateFromString(racerMap.get("birthday").toString()));
        racer.setDocument(racerMap.get("document").toString());
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
        LOG.trace("{} had added racer {} {} to team {} (id = {})",
                username, racer.getFirstName(), racer.getLastName(), racer
                        .getTeam().getName(), racer.getTeam().getId());
        LOG.debug("End addRacerAction method");
        return racer.getId();
    }

 // add doc action
    @RequestMapping(value = "/addDocs", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public @ResponseBody String addDocAction(MultipartHttpServletRequest request, HttpServletResponse response) { 
        Iterator<String> itr =  request.getFileNames();
        MultipartFile mpf = request.getFile(itr.next());
        System.out.println(mpf.getOriginalFilename() +" uploaded!");
        return "";
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
            method = RequestMethod.POST, headers = { "content-type=application/json" })
    public @ResponseBody
    List<Integer> getOccupiedDefaultNumbersForCarClassAction(@RequestBody Map<String, Object> map) {
        int carClassId = Integer.parseInt(map.get("carClassId").toString());
        try{
            List<RacerCarClassNumber> racers = racerCarClassNumberService.getNumbersByCarClassId(carClassId);
            ArrayList<Integer> numbers = new ArrayList<Integer>();
            for (RacerCarClassNumber racer : racers) {
                numbers.add(racer.getNumber());
            }
            return numbers;
        } catch(Exception e){
            return null;
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
        LOG.trace("{} has added car class with {} to racer {} {} (id = {})", 
        		username, carClass.getName(), number, racer.getFirstName(), racer.getLastName(), racerId);

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
        LOG.trace("{} has deleted racer {} {} (id = {})",
        		username, racer.getFirstName(), racer.getLastName(), racer.getId());

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
        LOG.trace("{} has {} racer {} {} (id = {})", 
        		username, (enabled ? "enabled" : "disabled"), racer.getFirstName(), racer.getLastName(), racer.getId());

        return "success";
    }
}