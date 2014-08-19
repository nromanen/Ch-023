package net.carting.web;

import net.carting.domain.*;
import net.carting.service.*;
import org.apache.log4j.Logger;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {

    @Autowired
    private DocumentService documentService;
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
    private LogsService logsService;
    @Autowired
    private FileService fileService;

    private static final Logger LOG = Logger.getLogger(AdminController.class);

    @RequestMapping(value = "/cabinet", method = RequestMethod.GET)
    public ModelAndView adminPage(Model model) {
        model.addAttribute("leadersList", leaderService.getAllLeaders());
        model.addAttribute("carClassList", carClassService.getAllCarClasses());
        model.addAttribute("adminSettings", adminSettingsService.getAdminSettings());
        model.addAttribute("pointsByPlacesList", adminSettingsService.getPointsByPlacesList());
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
        LOG.info("Admin has added new car class " + carClass.getName());
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
        LOG.info("Admin has edited car class " + carClass.getName() + " (id = " + carClass.getId() + ")");
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
            LOG.info("Admin has deleted car class with id = " + id);
        } catch (ConstraintViolationException e) {
            LOG.error("Admin hasn't deleted car class with id = " + id);
            result = "fail";
        }
        return result;
    }

    @RequestMapping(value = "/changePerentalPermissionYears", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String changePerentalPermissionYearsAction(@RequestBody Map<String, Object> map) {
        int perentalPermissionYears = Integer.parseInt(map.get("perentalPermissionYears").toString());
        adminSettingsService.updatePerentalPermissionYears(perentalPermissionYears);
        LOG.info("Admin has changed perental permission years to " + perentalPermissionYears);
        return "success";
    }

    @RequestMapping(value = "/changePointsByPlaces", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String changePointsByPlacesAction(@RequestBody Map<String, Object> map) {
        String pointsByPlaces = map.get("pointsByPlaces").toString();
        adminSettingsService.updatePointsByPlaces(pointsByPlaces);
        LOG.info("Admin has changed points by places to " + pointsByPlaces);
        return "success";
    }

    @RequestMapping(value = "/changeFeedbackEmail", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String changeFeedbackEmailAction(@RequestBody Map<String, Object> map) {
        String feedbackEmail = map.get("feedbackEmail").toString();
        adminSettingsService.updateFeedbackEmail(feedbackEmail);
        LOG.info("Admin has changed feedback email to " + feedbackEmail);
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
            LOG.info(username + " trying to change their password but incorrectly entered old password");
            return "error";
        }

        userService.changePassword(user, newPassword);
        LOG.info(username + " has successfuly changed their password");
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
        LOG.info("Admin has deleted leader " + leader.getFirstName() + " " + leader.getFirstName());
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
        LOG.info("Admin has reseted leader(" + leader.getFirstName() + " " + leader.getFirstName() + ") password to default");
        return "success";
    }

    @RequestMapping(value = "/uploadFiles", method = RequestMethod.GET)
    public
    @ResponseBody
    String uploadFiles() {
        String result = "success";
        try {

            File file = new File();
            Document document = new Document();
            document.setName("test");
            document.setApproved(false);
            document.setChecked(false);
//file.setFile();
            file.setDocument(document);
            fileService.addFile(file);

            //documentService.addDocument();
            LOG.info("Admin has uploaded documents to DB");
        } catch (Exception e) {
            result = "fail";
            LOG.info("Admin has failed to upload documents to DB");
        }
        return result;
    }

    @RequestMapping(value = "/downloadFiles", method = RequestMethod.GET)
    public
    @ResponseBody
    String saveFiles() {
        String result = "success";
        try {
//            filesService.downloadAll();
            LOG.info("Admin has downloaded documents from DB");
        } catch (Exception e) {
            result = "fail";
            LOG.info("Admin has failed to download documents from DB");
        }
        return result;
    }

    @RequestMapping(value = "/logs", method = RequestMethod.GET)
    public
    String getLogs(Model model) {
        List<Logs> list = logsService.getAllLogs();
        model.addAttribute("logs", list);
        return "logs";
    }

}
