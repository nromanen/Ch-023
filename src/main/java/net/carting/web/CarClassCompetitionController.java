package net.carting.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.CarClassCompetitionResult;
import net.carting.domain.Competition;
import net.carting.domain.Leader;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassCompetitionNumber;
import net.carting.domain.RacerCarClassNumber;
import net.carting.domain.Team;
import net.carting.service.CarClassCompetitionService;
import net.carting.service.RacerCarClassCompetitionNumberService;
import net.carting.domain.Race;
import net.carting.service.CarClassCompetitionResultService;
import net.carting.service.CarClassService;
import net.carting.service.CompetitionService;
import net.carting.service.LeaderService;
import net.carting.service.RaceService;
import net.carting.service.RacerCarClassNumberService;
import net.carting.service.RacerService;
import net.carting.service.TeamInCompetitionService;
import net.carting.service.TeamService;
import net.carting.service.UserService;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import net.carting.util.DateUtil;

@Controller
@RequestMapping(value = "/carclass")
public class CarClassCompetitionController {

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
	
	private static final Logger LOG = Logger.getLogger(CarClassCompetitionController.class);
	
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
		model.addAttribute("raceListSize",raceService.getRacesByCarClassCompetition(carClassCompetition).size());
		model.addAttribute("absoluteResultsList", carClassCompetitionResultService.getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition));
		return new ModelAndView("competition_carclass");
   }
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody
	String deleteCarClassCompetitionAction(@RequestBody Map<String, Object> map) {
		CarClassCompetition carClassCompetition = carClassCompetitionService
				.getCarClassCompetitionById(Integer.parseInt(map.get("id").toString()));
		try{
			carClassCompetitionService.deleteCarClassCompetition(carClassCompetition);
			LOG.info("Admin has deleted car class " + carClassCompetition.getCarClass().getName()
							+ " from competition " + carClassCompetition.getCompetition().getName() + ""
							+ "(id = " + carClassCompetition.getCompetition().getId() + ")");
		} catch(Exception e){
			LOG.info("Admin trying to delete car class " + carClassCompetition.getCarClass().getName()
							+ " from competition " + carClassCompetition.getCompetition().getName() + " "
							+ "(id = " + carClassCompetition.getCompetition().getId() + ")");
			return "error";
		}	
		return "success";
	}
	
	@RequestMapping(value = "/editAction", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody
	String editCarClassCompetitionAction(@RequestBody Map<String, Object> map) {
		CarClassCompetition carClassCompetition = new  CarClassCompetition();
		carClassCompetition.setId(Integer.parseInt(map.get("id").toString()));
		carClassCompetition.setFirstRaceTime(DateUtil.getTimeFromString(map.get("firstRaceTime").toString()));
		carClassCompetition.setSecondRaceTime(DateUtil.getTimeFromString(map.get("secondRaceTime").toString()));
		carClassCompetition.setCircleCount(Integer.parseInt(map.get("circleCount").toString()));
		carClassCompetition.setPercentageOffset(Integer.parseInt(map.get("percentageOffset").toString()));
		carClassCompetitionService.updateCarClassCompetition(carClassCompetition);
		LOG.info("Admin has edited car class competition (id = " + carClassCompetition.getId() + ")");
		return "success";
	}
	
	@RequestMapping(value = "/getRacersCountById", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody int getRacersCountByIdAction(@RequestBody Map<String, Object> map){
		int id = Integer.parseInt(map.get("id").toString());
		return racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersCountByCarClassCompetitionId(id);
	}
	
	@RequestMapping(value = "/{id}/unregisterRacer", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody
	String unregisterRacerFromCarClassCompetitionAction(@RequestBody Map<String, Object> map, @PathVariable("id") int id) {
		int carClassCompetitionId = id;
		int racerId = Integer.parseInt(map.get("racerId").toString());
		String username = userService.getCurrentUserName();
		Competition competition = carClassCompetitionService.getCarClassCompetitionById(carClassCompetitionId).getCompetition();
		Team team = racerService.getRacerById(racerId).getTeam();
		CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(carClassCompetitionId);
		
		try{		
			racerCarClassCompetitionNumberService.deleteByCarClassCompetitionIdAndRacerId(carClassCompetitionId, racerId);
			
			LOG.info(username + " has unregistered racer(id = " + racerId + ") "
						+ "from competition " + competition.getName() + "(id = " + competition.getId() + ") "
						+ "from car class " + carClassCompetition.getCarClass().getName() + "(id = " + carClassCompetitionId + ")");

			//if this racer was last from his team in this competition 
			//then unregister his team from this competition
			if(racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersByCompetitionIdAndTeamId(
					competition.getId(), team.getId()).size() == 0){
				teamInCompetitionService.deleteTeamInCompetitionByTeamIdAndCompetitionId(team.getId(), competition.getId());
				
				LOG.info(team.getName() + " has unregistered "
						+ "from competition " + competition.getName() + "(id = " + competition.getId() + ") "
						+ "because " + username + " has unregistered last racer from his team in this competition");
			}
			
		} catch(Exception e){
			LOG.info(username + " trying to unregister racer(id = " + racerId + ") "
					+ "from competition " + competition.getName() + "(id = " + competition.getId() + ") "
					+ "from car class " + carClassCompetition.getCarClass().getName() + "(id = " + carClassCompetitionId + ")");
			return "error";
		}		
		return "success";
	}
	
	@RequestMapping(value = "/getRacerNumber", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody
	int getRacerNumberAction(@RequestBody Map<String, Object> map) {
		int carClassId = Integer.parseInt(map.get("carClassId").toString());
		int racerId = Integer.parseInt(map.get("racerId").toString());
		RacerCarClassNumber racerCarClassNumber = racerCarClassNumberService.getRacerCarClassNumberByCarClassIdAndRacer(carClassId, racerId);
		return racerCarClassNumber.getNumber();
	}
	
	@RequestMapping(value = "/{id}/registerRacer", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody
	String registerRacerToCarClassCompetitionAction(@RequestBody Map<String, Object> map, @PathVariable("id") int id) {
		int carClassCompetitonId = id;
		int racerId = Integer.parseInt(map.get("racerId").toString());
		int number = Integer.parseInt(map.get("number").toString());
		RacerCarClassCompetitionNumber racerCarClassCompetitionNumber = new RacerCarClassCompetitionNumber();
		CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(carClassCompetitonId);
		racerCarClassCompetitionNumber.setCarClassCompetition(carClassCompetition);
		Racer racer = racerService.getRacerById(racerId);
		racerCarClassCompetitionNumber.setRacer(racer);
		racerCarClassCompetitionNumber.setNumberInCompetition(number);
		racerCarClassCompetitionNumberService.addRacerCarClassCompetitionNumber(racerCarClassCompetitionNumber);
		
		String username = userService.getCurrentUserName();
		Competition competition = carClassCompetition.getCompetition();
		LOG.info(username + " has registered racer " + racer.getFirstName() + " " + racer.getLastName()
				+ " (id = " + racerId + ") with number " + number + " "
				+ " to competition " + competition.getName() + "(id = " + competition.getId() + ") "
				+ " to car class " + carClassCompetition.getCarClass().getName() + "(id = " + carClassCompetitonId + ")");
		return "success";
	}
		
	@RequestMapping(value = "/{id}/addResults")
	public String addRacePage(Map<String, Object> map, @PathVariable("id") int id) {
		map.put("race", new Race());
		map.put("carClassCompetition", carClassCompetitionService.getCarClassCompetitionById(id));
		map.put("membersCount", racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersCountByCarClassCompetitionId(id));
		map.put("validNumbers",raceService.getNumbersArrayByCarClassCompetitionId(id));
		return "competition_carclass_results_add";
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
		
		LOG.info("Admin has added race with id=" + race.getId() 
				+ " race number "+race.getRaceNumber()
				+" in car class competition " + carClassCompetition.getCarClass().getName()
				+ " in competition "+carClassCompetition.getCompetition().getName());

		return "redirect:/carclass/"+id;
	}
	
	@RequestMapping(value = "/{id}/race/{raceNumber}/edit")
	public String editRacePage(Map<String, Object> map, @PathVariable("id") int id,@PathVariable("raceNumber") int raceNumber) {
		map.put("race", raceService.getRaceByNumberAndCarClassCompetition(raceNumber, carClassCompetitionService.getCarClassCompetitionById(id)));
		map.put("carClassCompetition", carClassCompetitionService.getCarClassCompetitionById(id));
		map.put("membersCount", racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersCountByCarClassCompetitionId(id));
		map.put("validNumbers",raceService.getNumbersArrayByCarClassCompetitionId(id));
		
		return "competition_carclass_results_edit";
	}
	
	@RequestMapping(value = "/{id}/race/{raceNumber}/editRace", method = RequestMethod.POST)
	public String editRace(@ModelAttribute("race") Race race,
		Map<String, Object> map, @PathVariable("id") int id, @PathVariable("raceNumber") int raceNumber) {
		CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(id);
		race.setCarClassCompetition(carClassCompetition);
		race.setId(raceService.getRaceByNumberAndCarClassCompetition(raceNumber, carClassCompetition).getId());
		race.setCarClass(carClassCompetition.getCarClass());
		race.setRaceNumber(raceNumber);
		raceService.updateRace(race);
		raceService.setResultTable(raceService.getChessRoll(race), race);
		carClassCompetitionResultService.recalculateAbsoluteResultsByEditedRace(carClassCompetition, race);
		
		LOG.info("Admin has edited race with id=" + race.getId() 
				+ " race number "+raceNumber
				+" in car class competition " + carClassCompetition.getCarClass().getName()
				+ " in competition "+carClassCompetition.getCompetition().getName());
		return "redirect:/carclass/"+id;
	}
	
	@RequestMapping(value = "/{id}/editSummaryResults")
	public String editSummaryResultsPage(Map<String, Object> map, @PathVariable("id") int id) {
		CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(id);
		map.put("absoluteResultsList", carClassCompetitionResultService.getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition));
		map.put("carClassCompetition",carClassCompetition);
		return "competetition_carclass_absoluteresults_edit";
		
	}
	
	@RequestMapping(value = "/{id}/editResults", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody String editSummaryResult(@RequestBody Map<String, Object> map, @PathVariable("id") int id){
		ArrayList<HashMap<String,String>> mapsList = (ArrayList<HashMap<String,String>>)map.get("jsonObject");
		CarClassCompetition carClassCompetition=carClassCompetitionService.getCarClassCompetitionById(id);
		LOG.info("Admin has edited  summary results in car class competition " + carClassCompetition.getCarClass().getName());
		for (HashMap<String,String> idAndPoint : mapsList){
		CarClassCompetitionResult result = carClassCompetitionResultService.getCarClassCompetitionResultById(Integer.parseInt(idAndPoint.get("id")));
			result.setAbsolutePoints(Integer.parseInt(idAndPoint.get("resultPoint")));
			carClassCompetitionResultService.updateCarClassCompetitionResult(result);
			LOG.info("Result with id=" +Integer.parseInt(idAndPoint.get("id"))+" has been changed to value "+Integer.parseInt(idAndPoint.get("resultPoint")));
		}
		carClassCompetitionResultService.recalculateAbsoluteResults(carClassCompetition);
		LOG.info("Result table has been recalculated ");
		return "success";
		
	}
	
	@RequestMapping(value = "/editConcreteResultAction", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody
	String editConcreteResultAction(@RequestBody Map<String, Object> map) {
		CarClassCompetitionResult carClassCompetitionResult = carClassCompetitionResultService.getCarClassCompetitionResultById(Integer.parseInt(map.get("id").toString()));
		
		carClassCompetitionResult.setAbsolutePoints(carClassCompetitionResult.getAbsolutePoints()+Integer.parseInt(map.get("fineValue").toString()));
		carClassCompetitionResult.setComment(map.get("comment").toString());
		LOG.info("Result of "+ carClassCompetitionResult.getRacerCarClassCompetitionNumber().getRacer().getLastName()
				+ " has been changed by " + carClassCompetitionResult.getComment());
		carClassCompetitionResultService.updateCarClassCompetitionResult(carClassCompetitionResult);
		carClassCompetitionResultService.recalculateAbsoluteResults(carClassCompetitionResult.getRacerCarClassCompetitionNumber().getCarClassCompetition());
		LOG.info("Result table has been recalculated ");
		return "success";
	}

}
