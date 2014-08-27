package net.carting.web;

import java.util.Map;

import net.carting.service.AdminSettingsService;
import net.carting.service.MailService;
import net.carting.service.UserService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/feedback")
public class FeedbackController {

    @Autowired
    MailService mailService;
    @Autowired
    private AdminSettingsService adminSettingsService;
    @Autowired
    private UserService userService;

    private static final Logger LOG = LoggerFactory.getLogger(FeedbackController.class);

    @RequestMapping(value = "", method = RequestMethod.GET)
    public ModelAndView feedbackPage(Model model) {
        return new ModelAndView("feedback");
    }

    @RequestMapping(value = "/sendMail", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String sendMailAction(@RequestBody Map<String, Object> map) {
        String to = adminSettingsService.getAdminSettings().getFeedbackEmail();
        String from = map.get("from").toString();
        String subject = map.get("subject").toString();
        String message = map.get("message").toString();
        mailService.sendMail(to, from, subject, message);

        String username = userService.getCurrentUserName();
        LOG.trace("{} (email = {}) sent letter to admin", username, from);

        return "success";
    }

}
