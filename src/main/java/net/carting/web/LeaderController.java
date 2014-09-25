package net.carting.web;

import net.carting.domain.Leader;
import net.carting.domain.Team;
import net.carting.domain.User;
import net.carting.service.*;
import net.carting.util.DateUtil;
import net.carting.validator.LeaderValidator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping(value = "/leader")
public class LeaderController {
    @Autowired
    private UserService userService;
    
    @Autowired
    private MessageSource messages;

    @Autowired
    private LeaderService leaderService;
    
    @Autowired
    private TeamService teamService;
    
    @Autowired
    private RoleService roleService;

    @Autowired
    MailService mailService;
    
    @Autowired
    private AdminSettingsService adminSettingsService;

    private static final Logger LOG = LoggerFactory.getLogger(LeaderController.class);

    private static final ThreadLocal<SimpleDateFormat> formatter = new ThreadLocal<SimpleDateFormat>() {
        @Override
        protected SimpleDateFormat initialValue() {
            return new SimpleDateFormat("yyyy-MM-dd");
        }
    };
    
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index() {
        String authority = userService.getCurrentAuthority();
        if (authority.equals(UserService.ROLE_ANONYMOUS)) {
            return "leader_registration";
        } else {
            return "index";
        }
    }

    @RequestMapping(value = "/addLeader", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, String> addLeader(@Valid Leader leader, Locale locale,  BindingResult bindingResult) {
    	LOG.debug("Start addLeader method");
        Map<String, String> result = new HashMap<String, String>();
        LeaderValidator validator = new LeaderValidator();
        validator.validate(leader, bindingResult);
        if (bindingResult.hasErrors()) {
        	List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
            	String message = messages.getMessage(fieldError.getCode(), null, locale);
                result.put(fieldError.getField(), message);
            }
        }
        else {
        	try {
				leaderService.registerLeader(leader);
			} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
			    /* TODO : show user an exception */
				LOG.error("Errors in addLeader method. Tried to add leader({} {})",leader.getFirstName(), leader.getLastName(), e);
			}
        }
        LOG.debug("End addLeader method");
        return result;
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String leaderPage(Map<String, Object> map, @PathVariable("id") int id) {
        Leader leader = leaderService.getLeaderById(id);
        map.put("currentLeader", leader);
        map.put("currentUserName", userService.getCurrentUserName());
        boolean isTeam = teamService.isTeamByLeaderId(leader.getId());
        map.put("isTeam", isTeam);
        if (isTeam) {
            Team team = teamService.getTeamByLeader(leader);
            map.put("team", team);
        }
        return "leader";
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String editLeaderPage(Map<String, Object> map) {
        String username = userService.getCurrentUserName();
        Leader leader = leaderService.getLeaderByUserName(username);
        map.put("leader", leader);

        if (teamService.isTeamByLeaderId(leader.getId())) {
            Team team = teamService.getTeamByLeader(leader);
            map.put("team", team);
        }
        map.put("leaderBirthday", formatter.get().format(leader.getBirthday()));
        return "leader_edit";
    }

    @RequestMapping(value = "/editLeader", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    int editLeader(@RequestBody Map<String, Object> formMap) {
    	LOG.debug("Start editLeader method");
        Leader leader = leaderService.getLeaderById(Integer.parseInt(formMap
                .get("id").toString()));
        leader.setFirstName(formMap.get("firstName").toString());
        leader.setLastName(formMap.get("lastName").toString());
        leader.setBirthday(DateUtil.getDateFromString(formMap.get("birthday")
                .toString()));
        leader.setDocument(formMap.get("document").toString());
        leader.setAddress(formMap.get("address").toString());
        leader.setLicense(formMap.get("license").toString());
        leader.getUser().setEmail(formMap.get("email").toString());
        leaderService.updateLeader(leader);
        LOG.trace("Leader {} {} had edited tracermation abut him",
                leader.getFirstName(), leader.getLastName());
        LOG.debug("End editLeader method");
        return leader.getId();
    }

    @RequestMapping(value = "/isSetUser", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    boolean isSetTeam(@RequestBody Map<String, Object> map) {
        String userName = map.get("username").toString();
        return userService.isSetUser(userName);
    }

    @RequestMapping(value = "/isSetEmail", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    boolean isSetEmail(@RequestBody Map<String, Object> map) {
        String email = map.get("email").toString();
        return userService.isSetEmail(email);
    }

    @RequestMapping(value = "/setEnabled", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String setLeaderEnabled(@RequestBody Map<String, Object> map) {
        String username = map.get("username").toString();
        boolean enabled = Boolean.parseBoolean(map.get("enabled").toString());
        userService.setEnabled(username, enabled);
        return "success";
    }
    
    @RequestMapping(value = "/passwordRecovery", method = RequestMethod.GET)
    public String passwordRecovery() {
        return "password_recovery";
    }
    
    @RequestMapping(value = "/sendSecureCode", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String sendSecureCode(@RequestBody Map<String, Object> map) {
    	String email = map.get("email").toString();
    	User user = userService.getUserByEmail(email);
    	userService.sendSecureCode(user);
    	return "success";
    }
    
    @RequestMapping(value = "/checkSecureCode", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String checkSecureCode(@RequestBody Map<String, Object> map) {
    	String email = map.get("email").toString();
    	String secureCode = map.get("secureCode").toString();
    	User user = userService.getUserByEmail(email);
    	if (user.getResetPassLink().equals(secureCode)) {
        	return "success";
    	}
    	else {
    		return "invalid";
    	}
    }
    
    @RequestMapping(value = "/changePassword", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    String changePassword(@RequestBody Map<String, Object> map) {
    	String email = map.get("email").toString();
    	String secureCode = map.get("secureCode").toString();
    	String password = map.get("password").toString();
    	User user = userService.getUserByEmail(email);
    	if (user.getResetPassLink().equals(secureCode)) {
    		try {
				userService.changePassword(user, password);
			} catch (NoSuchAlgorithmException | UnsupportedEncodingException e ) {
				LOG.error("Errors in changePassword method", e);
			}
    		return "success";
    	}
    	else {
    		return "invalid";
    	}
    }
    
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
    }
    

}
