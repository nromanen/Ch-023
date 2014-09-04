package net.carting.web;

import net.carting.service.LogsService;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * Created by manson on 9/5/14.
 */
@Controller
@RequestMapping(value = "/logs")
public class LogsController {

    @Autowired
    private LogsService logsService;

    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public ModelAndView getLogs(Model model) {
        Date date= new Date();
        DateTime end = new DateTime(date);
        DateTime start = end.minusDays(1);
        model.addAttribute("dateStart", new Timestamp(start.toDate().getTime()));
        model.addAttribute("dateEnd", new Timestamp(end.toDate().getTime()));
        List list = logsService.getAllLogs();
        model.addAttribute("logs", list);
        return new ModelAndView("all_logs");
    }

    @RequestMapping(value = "/today", method = RequestMethod.GET)
    public
    ModelAndView getLogsByDate(Model model) {
        Date date= new Date();
        DateTime end = new DateTime(date);
        DateTime start = end.minusDays(1);
        model.addAttribute("dateStart", new Timestamp(start.toDate().getTime()));
        model.addAttribute("dateEnd", new Timestamp(end.toDate().getTime()));
        List list = logsService.getLogsByPeriod(new Timestamp(start.toDate().getTime()), new Timestamp(end.toDate().getTime()));
        model.addAttribute("logs", list);
        return new ModelAndView("today_logs");
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public
    ModelAndView getLogsByDates(Model model, @RequestParam("start") String start, @RequestParam("end") String end) {
        model.addAttribute("dateStart", Timestamp.valueOf(start));
        model.addAttribute("dateEnd", Timestamp.valueOf(end));
        List list = logsService.getLogsByPeriod(Timestamp.valueOf(start), Timestamp.valueOf(end));
        model.addAttribute("logs", list);
        return new ModelAndView("search_logs");
    }

}
