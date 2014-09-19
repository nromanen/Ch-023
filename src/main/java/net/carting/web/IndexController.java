package net.carting.web;

import net.carting.service.AdminSettingsService;
import net.carting.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
public class IndexController {

    @Autowired
    private UserService userService;
    @Autowired
    private AdminSettingsService adminSettingsService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "index";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String root() {
        return "redirect:/index";
    }

    @RequestMapping(value = "/403", method = RequestMethod.GET)
    public String deniedOfAccess() {
        return "error_403";
    }

    @RequestMapping(value = "/loginPage", method = RequestMethod.GET)
    public String loginPage(
            @RequestParam(value = "error", required = false) String error,
            Map<String, Object> map) {

        if (error != null && error.equals("BadCredentialsException")) {
            map.put("error", "BadCredentialsException");
        } else if (error != null && error.equals("userDisabled")) {
            map.put("error", "userDisabled");
        }
        map.put("email", adminSettingsService.getAdminSettings().getFeedbackEmail());
        return "login_page";
    }

}
