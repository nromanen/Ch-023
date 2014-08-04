package net.carting.web;

import net.carting.domain.Leader;
import net.carting.domain.Team;
import net.carting.service.*;
import net.carting.util.DateUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Map;

@Controller
@RequestMapping(value = "/leader")
public class LeaderController {
    @Autowired
    private UserService userService;
    @Autowired
    private LeaderService leaderService;
    @Autowired
    private TeamService teamService;
    @Autowired
    private RoleService roleService;
    // private AuthorityService authorityService;
    @Autowired
    MailService mailService;
    @Autowired
    private AdminSettingsService adminSettingsService;

    private static final Logger LOG = Logger.getLogger(LeaderController.class);

    private static final ThreadLocal<SimpleDateFormat> formatter = new ThreadLocal<SimpleDateFormat>() {
        @Override
        protected SimpleDateFormat initialValue() {
            return new SimpleDateFormat("yyyy-MM-dd");
        }
    };

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index(Map<String, Object> map, HttpServletRequest request) {
        String authority = userService.getCurrentAuthority();
        if (authority.equals(UserService.ROLE_ANONYMOUS)) {
            map.put("locale", RequestContextUtils.getLocale(request).toString());
            return "leader_registration";
        } else {
            return "index";
        }
    }

    @RequestMapping(value = "/addLeader", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    boolean addLeader(@RequestBody Map<String, Object> formMap) {
        try {
            leaderService.registerLeader(formMap);
            return true;
        } catch (NoSuchAlgorithmException e) {
            LOG.info("Error encoding passwords: NoSuchAlgorithmException. On page leader registration");
            return false;
        } catch (UnsupportedEncodingException e) {
            LOG.info("Error encoding passwords: UnsupportedEncodingException. On page leader registration");
            return false;
        }
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
    public String editLeaderPage(Map<String, Object> map,
                                 @PathVariable("id") int id, HttpServletRequest request) {
        String username = userService.getCurrentUserName();
        Leader leader = leaderService.getLeaderByUserName(username);
        map.put("leader", leader);

        if (teamService.isTeamByLeaderId(leader.getId())) {
            map.put("locale", RequestContextUtils.getLocale(request).toString());
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

        Leader leader = leaderService.getLeaderById(Integer.parseInt(formMap
                .get("id").toString()));
        leader.setFirstName(formMap.get("firstName").toString());
        leader.setLastName(formMap.get("lastName").toString());
        leader.setBirthday(DateUtil.getDateFromString(formMap.get("birthday")
                .toString()));
        leader.setDocument(formMap.get("document").toString());
        leader.setAddress(formMap.get("address").toString());
        leader.setLicense(formMap.get("license").toString());
        leaderService.updateLeader(leader);
        LOG.info(String.format("Leader %s %s had edited information abut him",
                leader.getFirstName(), leader.getLastName()));

        return leader.getId();
    }

    @RequestMapping(value = "/isSetUser", method = RequestMethod.POST, headers = {"content-type=application/json"})
    public
    @ResponseBody
    boolean isSetTeam(@RequestBody Map<String, Object> map) {
        String userName = map.get("username").toString();
        return userService.isSetUser(userName);
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

}
