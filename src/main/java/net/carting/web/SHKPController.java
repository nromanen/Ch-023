package net.carting.web;

import com.itextpdf.text.Document;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import net.carting.domain.CarClass;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Competition;
import net.carting.domain.RacerCarClassCompetitionNumber;
import net.carting.service.CarClassCompetitionResultService;
import net.carting.service.CarClassCompetitionService;
import net.carting.service.CompetitionService;
import net.carting.service.RacerCarClassCompetitionNumberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.*;
import java.nio.charset.StandardCharsets;
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
        public String start(Model model, @RequestParam(value = "table", required = false) String table) {
            String pdf = "src/main/webapp/resources/documents/pdf/start.pdf";
            System.out.println("POST");
            try {
                InputStream stream = new ByteArrayInputStream(table.getBytes(StandardCharsets.UTF_8));
                Document document = new Document();
                FileOutputStream fos = new FileOutputStream(pdf);
                PdfWriter writer = PdfWriter.getInstance(document, fos);
                document.open();
                XMLWorkerHelper.getInstance().parseXHtml(
                        writer,
                        document,
                        stream
                );
                document.close();
                fos.close();
                stream.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
            return pdf;
        }

        @RequestMapping(value = "start/{id}", method = RequestMethod.GET)
        public ModelAndView astart(Model model, @PathVariable("id") int id) {
            System.out.println("GET");
            String pdf = "src/main/webapp/resources/documents/pdf/start.pdf";
            CarClassCompetition carClassCompetition = carClassCompetitionService.getCarClassCompetitionById(id);
            Competition competition = carClassCompetition.getCompetition();

            List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumberList =
                    racerCarClassCompetitionNumberService.getRacerCarClassCompetitionNumbersByCarClassCompetitionId(id);

            model.addAttribute("startedNumber", racerCarClassCompetitionNumberList.size());
            model.addAttribute("competitionName", competition.getName());
            model.addAttribute("allowedNumber", racerCarClassCompetitionNumberList.size());
            model.addAttribute("secretaryName", competition.getSecretaryName());
            model.addAttribute("carClassName", competition.getCarClassCompetitions().iterator().next().getCarClass().getName());


            model.addAttribute("racerCarClassCompetitionNumberList", racerCarClassCompetitionNumberList);
            String pdfLink = "/Carting/resources/documents/pdf/start.pdf";
            model.addAttribute("pdfLink", pdfLink);
            return new ModelAndView("start");
        }
}