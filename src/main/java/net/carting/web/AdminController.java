package net.carting.web;

import net.carting.domain.CarClass;
import net.carting.domain.Leader;
import net.carting.domain.Maneuver;
import net.carting.domain.User;
import net.carting.service.*;
import org.hibernate.exception.ConstraintViolationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {

    @Autowired
    private CarClassService carClassService;
    @Autowired
    private AdminSettingsService adminSettingsService;
    @Autowired
    private LeaderService leaderService;
    @Autowired
    private TeamService teamService;
    @Autowired
    private UserService userService;
    @Autowired
    private ManeuverService maneuverService;
    @Autowired
    FileService fileService;

    private static final Logger LOG = LoggerFactory.getLogger(AdminController.class);

    @RequestMapping(value = "/cabinet", method = RequestMethod.GET)
    public ModelAndView adminPage(Model model) {
        model.addAttribute("leadersList", leaderService.getAllLeaders());
        model.addAttribute("carClassList", carClassService.getAllCarClasses());
        model.addAttribute("adminSettings", adminSettingsService.getAdminSettings());
        model.addAttribute("pointsByPlacesList", adminSettingsService.getPointsByPlacesList());
        model.addAttribute("maneuvers", maneuverService.getAllManeuvers());
        return new ModelAndView("admin_cabinet");
    }

    @RequestMapping(value = "/addCarClass", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String addCarClassAction(@RequestBody Map<String, Object> map) {
        CarClass carClass = new CarClass();
        carClass.setName(map.get("name").toString());
        carClass.setLowerYearsLimit(Integer.parseInt(map.get("lowerYearsLimit").toString()));
        carClass.setUpperYearsLimit(Integer.parseInt(map.get("upperYearsLimit").toString()));
        carClassService.addCarClass(carClass);
        LOG.trace("Admin has added new car class {}", carClass.getName());
        return Integer.toString(carClass.getId());
    }

    @RequestMapping(value = "/editCarClass", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String editCarClassAction(@RequestBody Map<String, Object> map) {
        CarClass carClass = new CarClass();
        carClass.setId(Integer.parseInt(map.get("id").toString()));
        carClass.setName(map.get("name").toString());
        carClass.setLowerYearsLimit(Integer.parseInt(map.get("lowerYearsLimit").toString()));
        carClass.setUpperYearsLimit(Integer.parseInt(map.get("upperYearsLimit").toString()));
        carClassService.updateCarClass(carClass);
        LOG.trace("Admin has edited car class {} (id = {})", carClass.getName(), carClass.getId());
        return "success";
    }

    @RequestMapping(value = "/deleteCarClass", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String deleteCarClassAction(@RequestBody Map<String, Object> map) {
        String result = "success";
        int id = Integer.parseInt(map.get("id").toString());
        try {
            carClassService.deleteCarClassById(id);
            LOG.trace("Admin has deleted car class with id = {}", id);
        } catch (ConstraintViolationException e) {
            LOG.error("Admin hasn't deleted car class with id = {}", id);
            result = "fail";
        }
        return result;
    }

    @RequestMapping(value = "/changePerentalPermissionYears", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String changeParentalPermissionYearsAction(@RequestBody Map<String, Object> map) {
        int perentalPermissionYears = Integer.parseInt(map.get("perentalPermissionYears").toString());
        adminSettingsService.updatePerentalPermissionYears(perentalPermissionYears);
        LOG.trace("Admin has changed perental permission years to {}", perentalPermissionYears);
        return "success";
    }

    @RequestMapping(value = "/changePointsByPlaces", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String changePointsByPlacesAction(@RequestBody Map<String, Object> map) {
        String pointsByPlaces = map.get("pointsByPlaces").toString();
        adminSettingsService.updatePointsByPlaces(pointsByPlaces);
        LOG.trace("Admin has changed points by places to {}", pointsByPlaces);
        return "success";
    }

    @RequestMapping(value = "/changeFeedbackEmail", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String changeFeedbackEmailAction(@RequestBody Map<String, Object> map) {
        String feedbackEmail = map.get("feedbackEmail").toString();
        adminSettingsService.updateFeedbackEmail(feedbackEmail);
        LOG.trace("Admin has changed feedback email to {}", feedbackEmail);
        return "success";
    }

    @RequestMapping(value = "/changePassword", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String changePasswordAction(@RequestBody Map<String, Object> map)
            throws NoSuchAlgorithmException, UnsupportedEncodingException {

        String oldPassword = map.get("oldPassword").toString();
        String newPassword = map.get("newPassword").toString();

        String username = userService.getCurrentUserName();
        User user = userService.getUserByUserName(username);
        if (!user.getPassword().equals(userService.getEncodedPassword(oldPassword))) {
            LOG.trace("{} trying to change their password but incorrectly entered old password", username);
            return "error";
        }

        userService.changePassword(user, newPassword);
        LOG.trace("{} has successfuly changed their password", username);
        return "success";
    }

    @RequestMapping(value = "/deleteLeader", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String deleteLeader(@RequestBody Map<String, Object> map) {
        int leaderId = Integer.parseInt(map.get("id").toString());
        if (teamService.isTeamByLeaderId(leaderId)) {
            return "error";
        }
        Leader leader = leaderService.getLeaderById(leaderId);
        leaderService.deleteLeader(leader);
        LOG.trace("Admin has deleted leader {} {}", leader.getFirstName(), leader.getLastName());
        return "success";
    }

    @RequestMapping(value = "/resetLeaderPass", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String resetLeaderPass(@RequestBody Map<String, Object> map)
            throws NoSuchAlgorithmException, UnsupportedEncodingException {
        int leaderId = Integer.parseInt(map.get("id").toString());
        Leader leader = leaderService.getLeaderById(leaderId);
        userService.resetPassword(leader.getUser());
        LOG.trace("Admin has reseted leader({} {}) password to default",leader.getFirstName(), leader.getLastName());
        return "success";
    }

    @RequestMapping(value = "/addManeuver", method = RequestMethod.POST)
    @ResponseBody
    public String addManeuver(@RequestParam(value = "maneuverName") String maneuverName) {
        String result = "success";
        try {
            Maneuver maneuver = new Maneuver();
            maneuver.setName(maneuverName);
            maneuverService.addManeuver(maneuver);
        } catch (Exception e) {
            result = "fail";
        }
        return result;
    }

    @RequestMapping(value = "/deleteManeuver", method = RequestMethod.POST)
    @ResponseBody
    public String addManeuver(@RequestParam(value = "id") int id) {
        String result = "success";
        try {
            maneuverService.deleteManeuver(id);
        } catch (Exception e) {
            result = "fail";
        }
        return result;
    }

    @RequestMapping(value = "/updateManeuver", method = RequestMethod.POST)
    public
    @ResponseBody
    String updateManeuvers(@RequestBody List<Maneuver> maneuvers) {
        String result = "success";
        try {
            for (Maneuver maneuver : maneuvers) {
                int id = maneuver.getId();
                String newName = maneuver.getName();
                Maneuver updatedManeuver = new Maneuver();
                updatedManeuver.setId(id);
                updatedManeuver.setName(newName);
                maneuverService.updateManeuver(updatedManeuver);
            }
        } catch (Exception e) {
            result = "fail";
        }
        return result;
    }

    @RequestMapping(value = "createDump", method = RequestMethod.POST)
    public
    @ResponseBody
    String createDump() {
        return fileService.createDbDump("src/main/resources/documents/sql/") ? "success" : "fail";
    }

    @RequestMapping(value = "downloadFiles", method = RequestMethod.POST)
    public
    @ResponseBody
    String downloadFiles() {
        return fileService.downloadAllFiles("src/main/resources/documents/files") ? "success" : "fail";
    }

    @RequestMapping(value = "uploadDump", method = RequestMethod.POST)
    public
    @ResponseBody
    String uploadDump() {
        return fileService.uploadDbDump("src/main/resources/documents/sql/dump.sql") ? "success" : "fail";
    }
}
