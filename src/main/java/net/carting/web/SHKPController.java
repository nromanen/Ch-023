package net.carting.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.carting.domain.CarClass;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Competition;
import net.carting.domain.Qualifying;
import net.carting.domain.RacerCarClassCompetitionNumber;
import net.carting.service.CarClassCompetitionService;
import net.carting.service.DocumentService;
import net.carting.service.QualifyingService;
import net.carting.service.RacerCarClassCompetitionNumberService;

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
        public void createStartStatement(Model model, @RequestParam(value = "table", required = false) String table) {
            documentService.createStartStatement(table);
        }

        @RequestMapping(value = "start/{id}/{raceId}", method = RequestMethod.GET)
        public ModelAndView start(Model model, @PathVariable("id") int id, @PathVariable("raceId") int raceId) {
            CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(id);
            Competition competition = carClassCompetition.getCompetition();

            List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumberList =
                    racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersByCarClassCompetitionId(id);
            
            
            try{
            	List<Qualifying> beforeQ = qualifyingService.getQualifyingsByCarClassCompetition(carClassCompetition);
                List<Qualifying> resultQ = new ArrayList<Qualifying>();
	            for (int i=0;i<beforeQ.size();i++) {
	            	for (int j=0; j<beforeQ.size();j++) {
	            		if (racerCarClassCompetitionNumberList.get(i).getNumberInCompetition()==beforeQ.get(j).getRacerNumber()) {
	            			resultQ.add(beforeQ.get(j));
	            		}
	            	}
	            }
	            model.addAttribute("qualifyingList", resultQ);
	        } catch (Exception e) {
            	LOG.error("Errors in start method", e);
            }
            
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