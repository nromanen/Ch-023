package net.carting.web;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.carting.domain.AbsoluteTeamResults;
import net.carting.domain.AdminSettings;
import net.carting.domain.CarClass;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.CarClassCompetitionResult;
import net.carting.domain.Competition;
import net.carting.domain.File;
import net.carting.domain.Leader;
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
import net.carting.service.FileService;
import net.carting.service.LeaderService;
import net.carting.service.RaceService;
import net.carting.service.RacerCarClassCompetitionNumberService;
import net.carting.service.RacerService;
import net.carting.service.TeamInCompetitionService;
import net.carting.service.TeamService;
import net.carting.service.UserService;
import net.carting.util.CompetitionValidator;
import net.carting.util.DateUtil;
import net.carting.util.GlobalData;
import net.carting.util.PdfWriter;

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

import com.itextpdf.text.PageSize;

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
	private FileService fileService;

	private static final Logger LOG = LoggerFactory
			.getLogger(CompetitionController.class);

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ModelAndView competitionPage(Model model, @PathVariable("id") int id) {
		Competition competition = competitionService.getCompetitionById(id);
		Date checkdate = competition.getDateStart();
		List<Racer> racersBirthday = racerService.getBirthdayRacers(checkdate);
		model.addAttribute("competition", competition);
		List<CarClass> carClasses = carClassService.getAllCarClasses();
		List<CarClassCompetition> carClassCompetitions = carClassCompetitionService
				.getCarClassCompetitionsByCompetitionId(id);
		model.addAttribute("carClassList", competitionService
				.getDifferenceBetweenCarClassesAndCarClassCompetitions(
						carClasses, carClassCompetitions));
		model.addAttribute("racersBirthday", racersBirthday);
		model.addAttribute("carClassCompetitionList", carClassCompetitions);
		model.addAttribute("pointsByPlacesList",
				competitionService.getPointsByPlacesList(competition));
		return new ModelAndView("competition");
	}

	@RequestMapping(value = "/list/{year}/{page}", method = RequestMethod.GET)
	public ModelAndView competitionsPage(
			Model model,
			@PathVariable("year") String yearString,
			@PathVariable("page") int page,
			@RequestParam(value = "competitionsPerPage", required = false, defaultValue = "10") int competitionsPerPage) {
		if (yearString.equals("all")) {
			List<Competition> competitionList = competitionService
					.getAllCompetitionsByPage(page, competitionsPerPage);
			long countOfCompetitions = competitionService
					.getCountOfCompetitions();
			model.addAttribute("competitionList", competitionList);
			model.addAttribute("yearsList",
					competitionService.getCompetitionsYearsList());
			model.addAttribute("all", yearString);
			model.addAttribute("countOfCompetitions", countOfCompetitions);
			model.addAttribute("competitionsPerPage", competitionsPerPage);
		} else {
			int year;
			try {
				year = Integer.parseInt(yearString);
			} catch (NumberFormatException e) {
				year = 0;
			}
			if (!competitionService.getCompetitionsYearsList().contains(year)) {
				year = competitionService.getCompetitionsYearsList().get(0);
			}
			GlobalData.globalYear = year;
			List<Competition> competitionList = competitionService
					.getCompetitionsByYear(year);
			model.addAttribute("competitionList", competitionList);
			model.addAttribute("yearsList",
					competitionService.getCompetitionsYearsList());
			model.addAttribute("year", year);
		}

		return new ModelAndView("competitions");
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public ModelAndView addCompetitionPage(Model model) {
		return new ModelAndView("competition_add_edit");
	}

	@RequestMapping(value = "/addCompetition", method = RequestMethod.POST)
	public @ResponseBody String addCompetitionAction(
			@ModelAttribute("newCompetition") Competition competition,
			BindingResult result) {
		CompetitionValidator validator = new CompetitionValidator();
		validator.validate(competition, result);
		if (result.hasErrors()) {
			LOG.trace("Admin failed adding new competition {} (id = {})",
					competition.getName(), competition.getId());
			return "fail";
		}
		competition.setPointsByPlaces(adminSettingsService.getAdminSettings()
				.getPointsByPlaces());
		competitionService.addCompetition(competition);
		LOG.trace("Admin has added new competition {} (id = {}))",
				competition.getName(), competition.getId());
		return String.valueOf(competition.getId());
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody String deleteCompetitionAction(
			@RequestBody Map<String, Object> map) {
		Competition competition = competitionService.getCompetitionById(Integer
				.parseInt(map.get("id").toString()));
		try {
			competitionService.deleteCompetition(competition);
			LOG.trace("Admin has deleted competition {} (id = {})",
					competition.getName(), competition.getId());
		} catch (Exception e) {
			LOG.trace("Admin trying to delete competition {} (id = {})",
					competition.getName(), competition.getId());
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
			return new ModelAndView("redirect:/competition/"
					+ competition.getId());
		}
	}

	@RequestMapping(value = "/editAction", method = RequestMethod.POST)
	public String editCompetitionAction(
			@ModelAttribute("editedCompetition") Competition competition) {

		competitionService.updateCompetition(competition);
		List<CarClassCompetition> carClassCompetitions = carClassCompetitionService
				.getCarClassCompetitionsByCompetitionId(competition.getId());
		for (CarClassCompetition carClassCompetition : carClassCompetitions) {
			for (Race race : carClassCompetition.getRaces()) {
				raceService
						.setResultTable(raceService.getChessRoll(race), race);
				carClassCompetitionResultService
						.recalculateAbsoluteResultsByEditedRace(
								carClassCompetition, race);
			}
		}
		LOG.trace("Admin has edited competition {} (id = {})",
				competition.getName(), competition.getId());
		return "redirect:/competition/" + competition.getId();
	}

	@RequestMapping(value = "/{id}/addCarClass", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody String addCarClassCompetition(
			@PathVariable("id") int id, @RequestBody Map<String, Object> map) {
		Competition competition = competitionService.getCompetitionById(id);
		CarClassCompetition carClassCompetition = new CarClassCompetition();
		carClassCompetition.setCompetition(competition);
		carClassCompetition.setCarClass(carClassService.getCarClassById(Integer
				.parseInt(map.get("carClassId").toString())));
		carClassCompetition.setFirstRaceTime(DateUtil.getTimeFromString(map
				.get("firstRaceTime").toString()));
		carClassCompetition.setSecondRaceTime(DateUtil.getTimeFromString(map
				.get("secondRaceTime").toString()));
		carClassCompetition.setCircleCount(Integer.parseInt(map.get("lapCount")
				.toString()));
		carClassCompetition.setPercentageOffset(Integer.parseInt(map.get(
				"percentageOffset").toString()));
		carClassCompetitionService.addCarClassCompetition(carClassCompetition);
		LOG.trace(
				"Admin has added car class {} to competition with name {} (id = {})",
				carClassCompetition.getCarClass().getName(),
				competition.getName(), competition.getId());
		return Integer.toString(carClassCompetition.getId());
	}

	@RequestMapping(value = "/{id}/mandat", method = RequestMethod.GET)
	public String competitionMandatStatementPage(@PathVariable("id") int id,
			Map<String, Object> map) {

		List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumbers = racerCarClassCompetitionNumberService
				.getRacerCarClassCompetitionNumbersByCompetitionId(id);
		List<CarClassCompetition> carClassCompetitions = carClassCompetitionService
				.getCarClassCompetitionsByCompetitionId(id);

		map.put("teamList",
				competitionService
						.getTeamsFromRacerCarClassCompetitionNumbers(racerCarClassCompetitionNumbers));
		map.put("racerCarClassCompetitionNumbers",
				racerCarClassCompetitionNumbers);
		map.put("carClassCompetitions", carClassCompetitions);

		if (racerCarClassCompetitionNumbers.size() > 0) {
			map.put("competition", racerCarClassCompetitionNumbers.get(0)
					.getCarClassCompetition().getCompetition());
		}

		map.put("formater", new SimpleDateFormat("yyyy-MM-dd"));
		map.put("today", new Timestamp(new Date().getTime()));
		map.put("perentalPermissionYears", adminSettingsService
				.getAdminSettings().getParentalPermissionYears());

		return "competition_mandat";
	}

	@RequestMapping(value = "/{id}/personal", method = RequestMethod.GET)
	public String personalOffsetPage(@PathVariable("id") int id,
			Map<String, Object> map) {
		List<CarClassCompetition> carClassCompetitions = carClassCompetitionService
				.getCarClassCompetitionsByCompetitionId(id);
		List<List<List<RaceResult>>> raceResults = new ArrayList<List<List<RaceResult>>>();
		List<List<CarClassCompetitionResult>> carClassCompetitionResults = new ArrayList<List<CarClassCompetitionResult>>();
		List<Boolean> isSetQualifyingList = new ArrayList<Boolean>();
		for (CarClassCompetition carClassCompetition : carClassCompetitions) {
			raceResults.add(raceService
					.getRaceResultsByCarClassCompetition(carClassCompetition));
			carClassCompetitionResults
					.add(carClassCompetitionResultService
							.getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition));
			isSetQualifyingList.add(carClassCompetitionResultService
					.isSetQualifyingByCarClassCompetition(carClassCompetition));
		}
		map.put("carClassCompetitions", carClassCompetitions);
		map.put("raceResultsLists", raceResults);
		map.put("absoluteResultsList", carClassCompetitionResults);
		map.put("isSetQualifyingList", isSetQualifyingList);

		return "competition_personal_offset";
	}

	@RequestMapping(value = "/{id}/absolute_personal", method = RequestMethod.GET)
	public String absolutePersonalOffsetPage(@PathVariable("id") int id,
			Map<String, Object> map) {
		List<CarClassCompetition> carClassCompetitions = carClassCompetitionService
				.getCarClassCompetitionsByCompetitionId(id);
		List<List<List<RaceResult>>> raceResults = new ArrayList<List<List<RaceResult>>>();
		List<List<CarClassCompetitionResult>> carClassCompetitionResults = new ArrayList<List<CarClassCompetitionResult>>();
		List<Boolean> isSetQualifyingList = new ArrayList<Boolean>();
		for (CarClassCompetition carClassCompetition : carClassCompetitions) {
			raceResults.add(raceService
					.getRaceResultsByCarClassCompetition(carClassCompetition));
			carClassCompetitionResults
					.add(carClassCompetitionResultService
							.getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition));
			isSetQualifyingList.add(carClassCompetitionResultService
					.isSetQualifyingByCarClassCompetition(carClassCompetition));
		}

		for (List<CarClassCompetitionResult> ccrL : carClassCompetitionResults) {
			List<Double> finalPoints = new ArrayList<Double>();
			Map<Double, Integer> finalPointsAndPlaces = new LinkedHashMap<Double, Integer>();
			boolean isSetResult = true;
			for (CarClassCompetitionResult ccr : ccrL) {
				if (ccr.getAbsolutePlace() > 0) {
					int size = ccr.getRacerCarClassCompetitionNumber()
							.getCarClassCompetition()
							.getRacerCarClassCompetitionNumbers().size();
					ccr.setAbsolutePointsByTableB(AdminSettings
							.getPointFromTableB(ccr.getAbsolutePlace(), size));
					ccr.setAbsoluteSumm(ccr.getAbsolutePointsByTableB()
							+ ccr.getManeuverTime());
					finalPoints.add(ccr.getAbsoluteSumm());
				} else {
					ccr.setAbsolutePlace(0);
					ccr.setAbsolutePointsByTableB(0);
					ccr.setAbsoluteSumm(0);
					ccr.setFinalPlace(0);
					isSetResult = false;
				}
				Collections.sort(finalPoints);
				for (int i = 0; i < finalPoints.size(); i++) {
					finalPointsAndPlaces.put(
							finalPoints.get(finalPoints.size() - (i + 1)),
							i + 1);
				}
			}
			if (isSetResult) {
				for (CarClassCompetitionResult ccr : ccrL) {
					ccr.setFinalPlace(finalPointsAndPlaces.get(ccr
							.getAbsoluteSumm()));
				}
			}
		}
		map.put("carClassCompetitions", carClassCompetitions);
		map.put("raceResultsLists", raceResults);
		map.put("absoluteResultsList", carClassCompetitionResults);
		map.put("isSetQualifyingList", isSetQualifyingList);

		return "absolute_competition_personal_offset";
	}

	@RequestMapping(value = "/setEnabled", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody String setCompetitionEnabled(
			@RequestBody Map<String, Object> map) {
		int competitionId = Integer.parseInt(map.get("competitionId")
				.toString());
		boolean enabled = Boolean.parseBoolean(map.get("enabled").toString());
		competitionService.setEnabled(competitionId, enabled);
		LOG.trace("Admin has {} competition (id = {})", (enabled ? "enabled"
				: "disabled"), competitionId);
		return "success";
	}

	@RequestMapping(value = "/{id}/unregisterRacer", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody String unregisterRacerFromCompetitionAction(
			@RequestBody Map<String, Object> map, @PathVariable("id") int id) {
		int competitionId = id;
		int racerId = Integer.parseInt(map.get("racerId").toString());
		racerCarClassCompetitionNumberService.deleteByCompetitionIdAndRacerId(
				competitionId, racerId);
		LOG.trace(
				"Admin has unregistered racer(id = {}) from competition (id = {})",
				racerId, competitionId);
		return "success";
	}
	
	@RequestMapping(value = "/unregisterTeam", method = RequestMethod.POST, headers = { "content-type=application/json" })
    public @ResponseBody String unregisterTeamFromCompetitionAction(
            @RequestBody Map<String, Object> map) {
        int competitionId = Integer.parseInt(map.get("competitionId").toString());
        int teamId = Integer.parseInt(map.get("teamId").toString());
        
        Set<CarClassCompetition> carClassCompetitions = competitionService.getCompetitionById(competitionId).getCarClassCompetitions();
        for (CarClassCompetition ccc : carClassCompetitions) {
            List<RacerCarClassCompetitionNumber> rcccnL = racerCarClassCompetitionNumberService.
                    getRacerCarClassCompetitionNumbersByCarClassCompetitionIdAndTeamId(ccc.getId(), teamId);
            for (RacerCarClassCompetitionNumber rcccn : rcccnL) {
                racerCarClassCompetitionNumberService.deleteByCarClassCompetitionIdAndRacerId(ccc.getId(), rcccn.getRacer().getId());
            }
        }
        teamInCompetitionService.deleteTeamInCompetitionByTeamIdAndCompetitionId(teamId, competitionId);
        LOG.trace(
                "Admin has unregistered team(id = {}) from competition (id = {})",
                teamId, competitionId);
        return "success";
    }

	// team registration view
	@RequestMapping(value = "/chooseCompetition", method = RequestMethod.GET)
	public String chooseCompetition(Map<String, Object> map) {

		String username = userService.getCurrentUserName();
		Leader leader = leaderService.getLeaderByUserName(username);
		if (teamService.isTeamByLeaderId(leader.getId())) {
			map.put("competitionsList",
					competitionService.getAllEnabledCompetitions());
			return "choose_competition";
		} else {
			return "redirect:/index";
		}
	}

	// team registration view
	/* TODO Remove HttpServletRequest */
	@RequestMapping(value = "/teamRegistration", method = RequestMethod.GET)
	public String registrationTeamOnCompetitionView(
			Map<String, Object> map,
			@RequestParam(value = "competition", required = false) Integer competitionId) {
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
			map.put("carClassesCompetition",
					carClassCompetitionService.getAllCarClassCompetitions()); // ?
			map.put("racerCarClassNumber", new RacerCarClassNumber());
			map.put("competitionId", competitionId);
			return "competition_team_add";
		} else {

			return "redirect:/competition/chooseCompetition";
		}
	}

	// team registration action
	@RequestMapping(value = "/addTeam", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody int registrationTeamOnCompetitionAction(
			@RequestBody Map<String, Object> formMap) {
		racerCarClassCompetitionNumberService
				.registrationTeamRacersOnCompetition(formMap);
		int competitionId = Integer.parseInt(formMap.get("competitionId")
				.toString());
		return competitionId;
	}

	@RequestMapping(value = "/{id}/changePointsByPlaces", method = RequestMethod.POST, headers = { "content-type=application/json" })
	public @ResponseBody String changePointsByPlaces(
			@RequestBody Map<String, Object> map, @PathVariable("id") int id) {
		LOG.debug("Start changePointsByPlaces method");
		Competition competition = competitionService.getCompetitionById(id);
		String pointsByPlaces = map.get("pointsByPlaces").toString();
		competition.setPointsByPlaces(pointsByPlaces);
		competitionService.updateCompetition(competition);
		List<CarClassCompetition> carClassCompetitions = carClassCompetitionService
				.getCarClassCompetitionsByCompetitionId(competition.getId());
		for (CarClassCompetition carClassCompetition : carClassCompetitions) {
			for (Race race : carClassCompetition.getRaces()) {
				raceService
						.setResultTable(raceService.getChessRoll(race), race);
				carClassCompetitionResultService
						.recalculateAbsoluteResultsByEditedRace(
								carClassCompetition, race);
			}
		}
		LOG.debug("End changePointsByPlaces method");
		return "success";
	}

	@RequestMapping(value = "/{id}/teamsRanking", method = RequestMethod.GET)
	public String teamRankingPage(@PathVariable("id") int id,
			Map<String, Object> map) {
		Competition competition = competitionService.getCompetitionById(id);
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		map.put("competitionDate",
				dateFormat.format(competition.getDateStart()) + " - "
						+ dateFormat.format(competition.getDateEnd()));
		map.put("competition", competition);
		List<Team> teamList = teamInCompetitionService
				.getTeamsByCompetitionId(id);
		map.put("teamList", teamList);
		List<AbsoluteTeamResults> absoluteTeamResultsList = new ArrayList<AbsoluteTeamResults>();
		for (int i = 0; i < teamList.size(); i++) {
			AbsoluteTeamResults absTeamRes = new AbsoluteTeamResults();
			absTeamRes.setTeamId(teamList.get(i).getId());
			absTeamRes.setShkpPoints(getShKPResultForTeamByCompetitionId(
					competition.getId(), teamList.get(i)));
			absTeamRes.setManeuverPoints(getManResultForTeamByCompetitionId(
					competition.getId(), teamList.get(i)));
			absTeamRes.setAbsolutePoints(absTeamRes.getShkpPointPlace()
					.getPoints()
					+ absTeamRes.getManeuverPointPlace().getPoints());
			absoluteTeamResultsList.add(absTeamRes);
		}
		map.put("resultList", setPoints(absoluteTeamResultsList));
		return "teams_ranking";
	}

	public List<AbsoluteTeamResults> setPoints(
			List<AbsoluteTeamResults> absoluteTeamResultsList) {
		List<Integer> absPoints = new ArrayList<Integer>();
		List<Integer> shkpPoints = new ArrayList<Integer>();
		List<Integer> manPoints = new ArrayList<Integer>();
		for (AbsoluteTeamResults absTeamRes : absoluteTeamResultsList) {
			manPoints.add(absTeamRes.getManeuverPointPlace().getPoints());
			shkpPoints.add(absTeamRes.getShkpPointPlace().getPoints());
			absPoints.add(absTeamRes.getAbsolutePointPlace().getPoints());
		}
		Collections.sort(manPoints);
		Collections.sort(shkpPoints);
		Collections.sort(absPoints);
		if (manPoints.size() > 1) {
			for (int i = 0; i < manPoints.size(); i++) {
				for (int j = 0; j < manPoints.size(); j++) {
					if (manPoints.get(i) == absoluteTeamResultsList.get(j)
							.getManeuverPointPlace().getPoints()) {
						if (manPoints.get(i) == 0) {
							absoluteTeamResultsList.get(j).setManeuverPlace(
									manPoints.get(i));
						} else {
							absoluteTeamResultsList.get(j).setManeuverPlace(
									manPoints.size() - i);
						}
					}
				}
			}
		}
		if (shkpPoints.size() > 1) {
			for (int i = 0; i < shkpPoints.size(); i++) {
				for (int j = 0; j < shkpPoints.size(); j++) {
					if (shkpPoints.get(i) == absoluteTeamResultsList.get(j)
							.getShkpPointPlace().getPoints()) {
						if (shkpPoints.get(i) == 0) {
							absoluteTeamResultsList.get(j).setShkpPlace(
									shkpPoints.get(i));
						} else {
							absoluteTeamResultsList.get(j).setShkpPlace(
									shkpPoints.size() - i);
						}
					}
				}
			}
		}
		if (absPoints.size() > 1) {
			for (int i = 0; i < absPoints.size(); i++) {
				for (int j = 0; j < absPoints.size(); j++) {

					if (absPoints.get(i) == absoluteTeamResultsList.get(j)
							.getAbsolutePointPlace().getPoints()) {
						if (absPoints.get(i) == 0) {
							absoluteTeamResultsList.get(j).setAbsolutePlace(
									absPoints.get(i));
						} else {
							absoluteTeamResultsList.get(j).setAbsolutePlace(
									absPoints.size() - i);
						}
					}
				}
			}
		}
		return absoluteTeamResultsList;
	}

	public Integer getShKPResultForTeamByCompetitionId(int competitionId,
			Team team) {
		List<Integer> teamShKPRes = new ArrayList<Integer>();
		Competition competition = competitionService
				.getCompetitionById(competitionId);
		for (CarClassCompetition ccc : competition.getCarClassCompetitions()) {
			List<Integer> tempShKPRes = new ArrayList<Integer>();
			for (CarClassCompetitionResult cccr : carClassCompetitionResultService
					.getCarClassCompetitionResultsOrderedByPoints(ccc)) {
				if (cccr.getAbsolutePoints() > 0) {
					for (Racer racer : team.getRacers()) {
						if (racer
								.equals(cccr
										.getRacerCarClassCompetitionNumber()
										.getRacer())) {
							tempShKPRes.add(cccr.getAbsolutePoints());
						}
					}
				}
			}
			if (!tempShKPRes.isEmpty()) {
				Integer max = tempShKPRes.get(0);
				if (tempShKPRes.size() > 1) {
					for (Integer j : tempShKPRes) {
						if (j > max) {
							max = j;
						}
					}
				}
				teamShKPRes.add(max);
			}
		}
		return getSumFromList(teamShKPRes);
	}

	public Integer getManResultForTeamByCompetitionId(int competitionId,
			Team team) {
		List<Integer> teamManRes = new ArrayList<Integer>();
		for (CarClassCompetition ccc : competitionService.getCompetitionById(
				competitionId).getCarClassCompetitions()) {
			List<Integer> tempManRes = new ArrayList<Integer>();
			for (CarClassCompetitionResult cccr : carClassCompetitionResultService
					.getCarClassCompetitionResultsOrderedByPoints(ccc)) {
				if (cccr.getManeuverTime() > 0) {
					for (Racer racer : team.getRacers()) {
						if (racer
								.equals(cccr
										.getRacerCarClassCompetitionNumber()
										.getRacer())) {
							tempManRes.add(Double.valueOf(
									cccr.getManeuverTime()).intValue());
						}
					}
				}
			}
			if (!tempManRes.isEmpty()) {
				Integer max = tempManRes.get(0);
				if (tempManRes.size() > 1) {
					for (Integer j : tempManRes) {
						if (j > max) {
							max = j;
						}
					}
				}
				teamManRes.add(max);
			}
		}
		return getSumFromList(teamManRes);
	}

	public Integer getSumFromList(List<Integer> list) {
		if (list.size() == 1) {
			return list.get(0);
		}
		Collections.sort(list);
		int sum = 0;
		if (list.size() > 5) {
			for (int i = list.size() - 1; i > list.size() - 6; i--) {
				sum = sum + list.get(i);
			}
		} else {
			for (int i = 0; i < list.size(); i++) {
				sum = sum + list.get(i);
			}
		}
		return sum;
	}

	@RequestMapping(value = "absRanking", method = RequestMethod.POST)
	@ResponseBody
	public int createAbsoluteRankingStatement(
			@RequestParam(value = "table") String table,
			@RequestParam(value = "competitionId") int competitionId) {
		int result;
		try {
			Competition competition = competitionService
					.getCompetitionById(competitionId);
			File absoluteCompetitionResults;
			if (competition.getAbsoluteResultsStatement() == null) {
				absoluteCompetitionResults = new File();
			} else {
				absoluteCompetitionResults = competition
						.getAbsoluteResultsStatement();
			}
			absoluteCompetitionResults.setFile(PdfWriter.getFileBytes(table,
					PageSize.A4.rotate()));
			String fileName = "AbsoluteTeamsRankingStatement_" + competitionId
					+ "_" + Calendar.getInstance().getTimeInMillis();
			absoluteCompetitionResults.setName(fileName);
			competition.setAbsoluteResultsStatement(absoluteCompetitionResults);
			competitionService.updateCompetition(competition);
			result = competition.getAbsoluteResultsStatement().getId();
		} catch (Exception e) {
			result = 0;
			e.printStackTrace();
		}
		return result;
	}

}
