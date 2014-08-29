package net.carting.web;

import java.text.SimpleDateFormat;
import java.util.*;

import com.itextpdf.text.PageSize;
import net.carting.domain.*;
import net.carting.service.CarClassCompetitionService;
import net.carting.service.DocumentService;
import net.carting.service.QualifyingService;
import net.carting.service.RacerCarClassCompetitionNumberService;

import net.carting.util.PdfWriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
    * Carting
    * Created by manson on 8/5/14.
    */
@Controller
@RequestMapping(value = "/SHKP")
public class SHKPController {

        // MAX_CAR_POSITIONS - max cart positions on the track, const.
        public static final int MAX_CAR_POSITIONS = 36;
        
        private static final Logger LOG = LoggerFactory.getLogger(SHKPController.class);

        @Autowired
        DocumentService documentService;

        @Autowired
        CarClassCompetitionService carClassCompetitionService;

        @Autowired
        RacerCarClassCompetitionNumberService racerCarClassCompetitionNumberService;
        
        @Autowired
        QualifyingService qualifyingService;

    @RequestMapping(value = "start", method = RequestMethod.POST)
    @ResponseBody
    public int createStartStatement(Model model, @RequestParam(value = "table") String table,
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
            start.setFile(PdfWriter.getFileBytes(table, PageSize.A4_LANDSCAPE));
            String fileName = "StartStatement_" + raceId + "_"
                    + Calendar.getInstance().getTimeInMillis();
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

    @RequestMapping(value = "maneuver", method = RequestMethod.POST)
    @ResponseBody
    public int createManeuverStatement(Model model, @RequestParam(value = "table") String table,
                                       @RequestParam(value = "raceId") int raceId) {
        int result;
        try {
            CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(raceId);
            File maneuver;
            if (carClassCompetition.getManeuverStatement() == null) {
                maneuver = new File();
            } else {
                maneuver = carClassCompetition.getManeuverStatement();
            }
            maneuver.setFile(PdfWriter.getFileBytes(table, PageSize.A1));
            String fileName = "ManeuverStatement_" + raceId + "_"
                    + Calendar.getInstance().getTimeInMillis();
            maneuver.setName(fileName);
            carClassCompetition.setManeuverStatement(maneuver);
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


        try {
            List<Qualifying> beforeQ = qualifyingService.getQualifyingsByCarClassCompetition(carClassCompetition);
            List<Qualifying> resultQ = new ArrayList<Qualifying>();
            if (beforeQ != null) {
                for (int i = 0; i < beforeQ.size(); i++) {
                    for (Qualifying aBeforeQ : beforeQ) {
                        if (racerCarClassCompetitionNumberList.get(i).getNumberInCompetition() == aBeforeQ.getRacerNumber()) {
                            resultQ.add(aBeforeQ);
                        }
                    }
                }
                model.addAttribute("qualifyingList", resultQ);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("startId", raceId);
        model.addAttribute("raceId", id);
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
        model.addAttribute("racerCarClassCompetitionNumberList", racerCarClassCompetitionNumberList);
        return new ModelAndView("start");
    }

    @RequestMapping(value = "maneuver/{id}", method = RequestMethod.GET)
    public ModelAndView createManeuverStatement(Model model, @PathVariable("id") int id) {
        try {
            CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(id);
            Competition competition = carClassCompetition.getCompetition();

            List<RacerCarClassCompetitionNumber> racers =
                    racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersByCarClassCompetitionId(id);

            model.addAttribute("racers", racers);
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
            model.addAttribute("tableB", Arrays.asList(AdminSettings.POINTS_BY_TABLE_B.get(racers.size()).split(",")));
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("maneuver");
    }
}