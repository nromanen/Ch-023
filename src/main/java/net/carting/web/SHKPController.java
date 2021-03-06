package net.carting.web;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.itextpdf.text.PageSize;
import net.carting.domain.AdminSettings;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.CarClassCompetitionResult;
import net.carting.domain.Competition;
import net.carting.domain.File;
import net.carting.domain.RacerCarClassCompetitionNumber;
import net.carting.service.CarClassCompetitionResultService;
import net.carting.service.CarClassCompetitionService;
import net.carting.service.DocumentService;
import net.carting.service.ManeuverService;
import net.carting.service.RacerCarClassCompetitionNumberService;

import net.carting.util.PdfWriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

/**
    * Carting
    * Created by manson on 8/5/14.
    */
@Controller
@RequestMapping(value = "/SHKP")
public class SHKPController {

        // MAX_CAR_POSITIONS - max cart positions on the track, const.
        public static final int MAX_CAR_POSITIONS = 24;

        public static final int TABLE_ROWS = 3;

        private static final Logger LOG = LoggerFactory.getLogger(SHKPController.class);

        @Autowired
        DocumentService documentService;

        @Autowired
        CarClassCompetitionService carClassCompetitionService;

        @Autowired
        RacerCarClassCompetitionNumberService racerCarClassCompetitionNumberService;

        @Autowired
        ManeuverService maneuverService;

        @Autowired
        CarClassCompetitionResultService carClassCompetitionResultService;

        @RequestMapping(value = "start", method = RequestMethod.POST)
        @ResponseBody
        public int createStartStatement(@RequestParam(value = "table") String table,
                                         @RequestParam(value = "raceId") int raceId,
                                         @RequestParam(value = "startId") int startId) {
            int result;
            try {
                CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(raceId);
                File start;
                if (startId == 1) {
                    if (carClassCompetition.getFirstRaceStartStatement() == null) {
                        start = new File();
                    } else {
                        start = carClassCompetition.getFirstRaceStartStatement();
                    }
                } else {
                    if (carClassCompetition.getSecondRaceStartStatement() == null) {
                        start = new File();
                    } else {
                        start = carClassCompetition.getSecondRaceStartStatement();
                    }
                }
                start.setFile(PdfWriter.getFileBytes(table, PageSize.A4.rotate()));
                String fileName = "StartStatement_" + raceId + "_" + "_" + startId
                        + Calendar.getInstance().getTimeInMillis() + ".pdf";
                start.setName(fileName);
                if (startId == 1) {
                    carClassCompetition.setFirstRaceStartStatement(start);
                } else {
                    carClassCompetition.setSecondRaceStartStatement(start);
                }
                carClassCompetitionService.updateCarClassCompetition(carClassCompetition);

                if (startId == 1) {
                    result = carClassCompetitionService.getCarClassCompetitionById(raceId).getFirstRaceStartStatement().getId();
                } else {
                    result = carClassCompetitionService.getCarClassCompetitionById(raceId).getSecondRaceStartStatement().getId();
                }
            } catch (Exception e) {
                result = 0;
                e.printStackTrace();
            }
            return result;
        }
        // create pdf for personal offset
        @RequestMapping(value = "/personal", method = RequestMethod.POST)
        @ResponseBody
        public int createPersonalOffsetStatement(@RequestParam(value = "table") String table,
                                         @RequestParam(value = "carClassCompetitionId") int carClassCompetitionId) {
            int result;
            try {
                CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(carClassCompetitionId);
                File personalOffset;
                if (carClassCompetition.getPersonalOffset() == null) {
                    personalOffset = new File();
                } else {
                    personalOffset = carClassCompetition.getPersonalOffset();
                }
                personalOffset.setFile(PdfWriter.getFileBytes(table, PageSize.A4.rotate())); // create pdf file, created from valid xhtml data
                String fileName = "PersonalOffset_" + carClassCompetitionId + "_"
                        + Calendar.getInstance().getTimeInMillis() + ".pdf";
                personalOffset.setName(fileName);
                carClassCompetition.setPersonalOffset(personalOffset); // set personal offset file to rhis car class competition
                carClassCompetitionService.updateCarClassCompetition(carClassCompetition); // and update car class competition
                result = carClassCompetitionService.getCarClassCompetitionById(carClassCompetitionId).getPersonalOffset().getId(); 
            } catch (Exception e) {
                result = 0;
                LOG.error("Errors in creating PDF for personalOffset", e);
            }
            return result;
        }

    @RequestMapping(value = "maneuver", method = RequestMethod.POST)
    @ResponseBody
    public int createManeuverStatement(@RequestParam(value = "table") String table,
                                          @RequestParam(value = "raceId") int raceId,
                                          @RequestParam(value = "ids")  List<Integer> idArray,
                                          @RequestParam(value = "times")  List<Double> timeArray) {
        int result;
        try {
            CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(raceId);
            File maneuver;
            if (carClassCompetition.getManeuverStatement() == null) {
                maneuver = new File();
            } else {
                maneuver = carClassCompetition.getManeuverStatement();
            }
            maneuver.setFile(PdfWriter.getFileBytes(table, PageSize.A4.rotate()));
            String fileName = "ManeuverStatement_" + raceId + "_"
                    + Calendar.getInstance().getTimeInMillis() + ".pdf";
            maneuver.setName(fileName);
            carClassCompetition.setManeuverStatement(maneuver);
            List<CarClassCompetitionResult> competitionResults = carClassCompetitionResultService.getCarClassCompetitionResultsByCarClassCompetition(carClassCompetition);
            for (CarClassCompetitionResult competitionResult : competitionResults) {
                for (int i = 0; i < idArray.size(); i++) {
                    int racerId = idArray.get(i);
                    double maneuverTime = timeArray.get(i);
                    if (competitionResult.getRacerCarClassCompetitionNumber().getNumberInCompetition() == racerId) {
                        competitionResult.setManeuverTime(maneuverTime);
                        carClassCompetitionResultService.updateCarClassCompetitionResult(competitionResult);
                    }
                }
            }
            carClassCompetitionService.updateCarClassCompetition(carClassCompetition);
            result = carClassCompetitionService.getCarClassCompetitionById(raceId).getManeuverStatement().getId();
        } catch (Exception e) {
            result = 0;
            e.printStackTrace();
        }
        return result;
    }

        @RequestMapping(value = "start/{id}/{raceId}", method = RequestMethod.GET)
        public ModelAndView start(Model model, @PathVariable("id") int id, @PathVariable("raceId") int raceId) {
            CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(id);
            Competition competition = carClassCompetition.getCompetition();
            List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumberList =
                    racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersByCarClassCompetitionId(id);
            List<CarClassCompetitionResult> carClassCompetitionResultList = carClassCompetitionResultService.
                    getCarClassCompetitionResultsOrderedByQualifyingTimes(carClassCompetition);
            try {
                if (carClassCompetitionResultList != null) {
                    model.addAttribute("cccResList", carClassCompetitionResultList);
                    model.addAttribute("isSetQualifying", carClassCompetitionResultService.isSetQualifyingByCarClassCompetition(carClassCompetition));
                }
            } catch (Exception e) {
                LOG.error("Errors in start method", e);
            }
            model.addAttribute("racerCarClassCompetitionNumberList", racerCarClassCompetitionNumberList);
            model.addAttribute("startId", raceId);
            model.addAttribute("raceId", id);
            model.addAttribute("tableRows", TABLE_ROWS);

            model.addAttribute("startedNumber", racerCarClassCompetitionNumberList.size());
            model.addAttribute("competitionName", competition.getName());
            model.addAttribute("competitionLoc", competition.getPlace());
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");

            model.addAttribute("competitionDate", dateFormat.format(competition.getDateStart()) + " - " + dateFormat.format(competition.getDateEnd()));

            model.addAttribute("allowedNumber", racerCarClassCompetitionNumberList.size());
            model.addAttribute("secretaryName", competition.getSecretaryName());
            Date time;
            Date date;

            if (raceId == 1) {
                date = competition.getFirstRaceDate();
                time = carClassCompetition.getFirstRaceTime();
                if (carClassCompetition.getFirstRaceStartStatement() != null) {
                    model.addAttribute("oldDoc", carClassCompetition.getFirstRaceStartStatement().getId());
                }
            } else {
                date = competition.getSecondRaceDate();
                time = carClassCompetition.getSecondRaceTime();
                if (carClassCompetition.getSecondRaceStartStatement() != null) {
                    model.addAttribute("oldDoc", carClassCompetition.getSecondRaceStartStatement().getId());
                }
            }

            model.addAttribute("carClassName", carClassCompetition.getCarClass().getName());
            model.addAttribute("carClassTime", timeFormat.format(time));
            model.addAttribute("carClassDate", dateFormat.format(date));
            model.addAttribute("carClassRace", raceId);
            model.addAttribute("maxPositions", MAX_CAR_POSITIONS);
            return new ModelAndView("start");
        }

    @RequestMapping(value = "maneuver/{id}", method = RequestMethod.GET)
    public ModelAndView createManeuverStatement(Model model, @PathVariable("id") int id) {
        try {
            CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(id);
            Competition competition = carClassCompetition.getCompetition();

            List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumberList =
                    racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersByCarClassCompetitionId(id);

            model.addAttribute("racerCarClassCompetitionNumberList", racerCarClassCompetitionNumberList);
            model.addAttribute("raceId", id);
            model.addAttribute("competitionName", competition.getName());
            model.addAttribute("competitionPlace", competition.getPlace());
            model.addAttribute("carClassName", carClassCompetition.getCarClass().getName());
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");

            if (carClassCompetition.getManeuverStatement() != null) {
                model.addAttribute("oldDoc", carClassCompetition.getManeuverStatement().getId());
            } else {
                model.addAttribute("oldDoc", null);
            }

            model.addAttribute("competitionDate", dateFormat.format(competition.getDateStart()) + " - " + dateFormat.format(competition.getDateEnd()));
            model.addAttribute("secretaryName", competition.getSecretaryName());
            model.addAttribute("directorName", competition.getDirectorName());
            model.addAttribute("judgeSecretary", competition.getSecretaryCategoryJudicialLicense());
            model.addAttribute("judgeDirector", competition.getDirectorCategoryJudicialLicense());
            model.addAttribute("tableB", Arrays.asList(AdminSettings.POINTS_BY_TABLE_B.get(racerCarClassCompetitionNumberList.size()).split(",")));

            model.addAttribute("maneuvers", maneuverService.getAllManeuvers());
        }
        catch (Exception e) {
             e.printStackTrace();
        }
        return new ModelAndView("maneuver");
    }
}