package net.carting.web;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.Competition;
import net.carting.domain.RacerCarClassCompetitionNumber;
import net.carting.service.CarClassCompetitionService;
import net.carting.service.RacerCarClassCompetitionNumberService;
import net.carting.util.documents.PdfWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
    * Carting
    * Created by manson on 8/5/14.
    */
@Controller
@RequestMapping(value = "/SHKP")
public class SHKPController {

        @Autowired
        CarClassCompetitionService carClassCompetitionService;

        @Autowired
        RacerCarClassCompetitionNumberService racerCarClassCompetitionNumberService;

        @RequestMapping(value = "start", method = RequestMethod.POST)
        @ResponseBody
        public String getDocument(Model model, @RequestParam(value = "table", required = false) String table) {
            //TODO: add to start document race number, start time, place, date
            //TODO: validation: cannot be same numbers in table, place number cannot be <0 && > MAX_POS
            try {
                PdfWriter.createStartStatement(table);

            } catch (Exception e) {
                e.printStackTrace();
            }
            return PdfWriter.getStartStatementPath();
        }

        @RequestMapping(value = "start/{id}", method = RequestMethod.GET)
        public ModelAndView start(Model model, @PathVariable("id") int id) {
            CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(id);
            Competition competition = carClassCompetition.getCompetition();

            List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumberList =
                    racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersByCarClassCompetitionId(id);

            model.addAttribute("startedNumber", racerCarClassCompetitionNumberList.size());
            model.addAttribute("competitionName", competition.getName());
            model.addAttribute("allowedNumber", racerCarClassCompetitionNumberList.size());
            model.addAttribute("secretaryName", competition.getSecretaryName());
            model.addAttribute("carClassName", competition.getCarClassCompetitions().iterator().next().getCarClass().getName());
            // 36 - Magic Number, max cart positions on the track.
            model.addAttribute("maxPositions", 36);
            model.addAttribute("racerCarClassCompetitionNumberList", racerCarClassCompetitionNumberList);
            String pdfLink = "/Carting/resources/documents/pdf/start.pdf";
            model.addAttribute("pdfLink", pdfLink);
            return new ModelAndView("start");
        }
}