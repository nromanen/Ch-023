package net.carting.web;

import net.carting.domain.Logs;
import net.carting.service.LogsService;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

    private static final Logger LOG = LoggerFactory.getLogger(LogsController.class);

    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public ModelAndView getLogs(Model model) {
        Date date= new Date();
        DateTime end = new DateTime(date);
        DateTime start = end.minusDays(1);
        model.addAttribute("dateStart", start.toDate());
        model.addAttribute("dateEnd", end.toDate());
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
        model.addAttribute("dateStart", start.toDate());
        model.addAttribute("dateEnd", end.toDate());
        List list = logsService.getLogsByPeriod(start.toDate(), end.toDate());
        model.addAttribute("logs", list);
        return new ModelAndView("today_logs");
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public
    ModelAndView getLogsByDates(Model model, @RequestParam("start") String start, @RequestParam("end") String end) {
        DateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");
        try {
            List list = logsService.getLogsByPeriod(formatter.parse(start), formatter.parse(end));
            model.addAttribute("dateStart", formatter.parse(start));
            model.addAttribute("dateEnd", formatter.parse(end));
            model.addAttribute("logs", list);
        } catch (ParseException e) {
            LOG.error("Errors in search logs method.)", e);
        }
        return new ModelAndView("search_logs");
    }

}
