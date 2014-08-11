package net.carting.web;

import net.carting.domain.CarClass;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Competition;
import net.carting.domain.RacerCarClassCompetitionNumber;
import net.carting.service.CarClassCompetitionService;
import net.carting.service.DocumentService;
import net.carting.service.RacerCarClassCompetitionNumberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
    * Carting
    * Created by manson on 8/5/14.
    */
@Controller
@RequestMapping(value = "/SHKP")
public class SHKPController {

        // MAX_CAR_POSITIONS - max cart positions on the track, const.
        public static final int MAX_CAR_POSITIONS = 36;

        @Autowired
        DocumentService documentService;

        @Autowired
        CarClassCompetitionService carClassCompetitionService;

        @Autowired
        RacerCarClassCompetitionNumberService racerCarClassCompetitionNumberService;

        @RequestMapping(value = "start", method = RequestMethod.POST)
        @ResponseBody
        public void createStartStatement(Model model, @RequestParam(value = "table", required = false) String table) {
            documentService.createStartStatement(table);
        }

        @RequestMapping(value = "start/{id}/{raceId}", method = RequestMethod.GET)
        public ModelAndView start(Model model, @PathVariable("id") int id, @PathVariable("raceId") int raceId) {
            CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(id);
            Competition competition = carClassCompetition.getCompetition();

            List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumberList =
                    racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersByCarClassCompetitionId(id);

            model.addAttribute("startedNumber", racerCarClassCompetitionNumberList.size());
            model.addAttribute("competitionName", competition.getName());
            model.addAttribute("competitionLoc", competition.getPlace());
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");


            model.addAttribute("competitionDate", dateFormat.format(competition.getDateStart()) + " - " + dateFormat.format(competition.getDateEnd()));

            model.addAttribute("allowedNumber", racerCarClassCompetitionNumberList.size());
            model.addAttribute("secretaryName", competition.getSecretaryName());
            CarClass carClass = competition.getCarClassCompetitions().iterator().next().getCarClass();
            Date time;
            Date date;
            if (raceId == 1) {
                date = competition.getFirstRaceDate();
                time = carClassCompetition.getFirstRaceTime();
            } else {
                date = competition.getSecondRaceDate();
                time = carClassCompetition.getSecondRaceTime();
            }
            model.addAttribute("carClassName", carClass.getName());
            model.addAttribute("carClassTime", timeFormat.format(time));
            model.addAttribute("carClassDate", dateFormat.format(date));
            model.addAttribute("carClassRace", raceId);

            model.addAttribute("maxPositions", MAX_CAR_POSITIONS);
            model.addAttribute("racerCarClassCompetitionNumberList", racerCarClassCompetitionNumberList);
            model.addAttribute("pdfLink", DocumentService.START_STATEMENT_PATH);
            return new ModelAndView("start");
        }
}