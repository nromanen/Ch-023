package net.carting.service;

import net.carting.dao.LeaderDAO;
import net.carting.domain.Leader;
import net.carting.domain.Role;
import net.carting.domain.User;
import net.carting.util.DateUtil;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class LeaderServiceImpl implements LeaderService {
    @Autowired
    private LeaderDAO leaderDAO;

    @Autowired
    //private AuthorityService authorityService;
    private RoleService roleService;

    @Autowired
    private UserService userService;

    @Autowired
    private AdminSettingsService adminSettingsService;

    @Autowired
    private MailService mailService;

    private static final Logger LOG = Logger.getLogger(LeaderServiceImpl.class);

    @Override
    @Transactional
    public List<Leader> getAllLeaders() {
        return leaderDAO.getAllLeaders();
    }

    @Override
    @Transactional
    public Leader getLeaderById(int id) {
        return leaderDAO.getLeaderById(id);
    }

    @Override
    @Transactional
    public void addLeader(Leader leader) {
        leaderDAO.addLeader(leader);
    }

    @Override
    @Transactional
    public void updateLeader(Leader leader) {
        leaderDAO.updateLeader(leader);
    }

    @Override
    @Transactional
    public void deleteLeader(Leader leader) {
        leaderDAO.deleteLeader(leader);
    }

    
    @Override
    @Transactional
    public Leader getLeaderByUserName(String username) {
        return leaderDAO.getLeaderByUserName(username);
    }
    
    /*
    @Override
    @Transactional
    public Leader getLeaderByUserId(int userId) {
        return leaderDAO.getLeaderByUserId(userId);
    }
*/
    @Override
    @Transactional
    public void registerLeader(Map<String, Object> formMap)
            throws NoSuchAlgorithmException, UnsupportedEncodingException {
        String username = formMap.get("username").toString();
/*
        Authority authority = new Authority();
        authority.setUsername(username);
        authority.setAuthority(UserService.ROLE_TEAM_LEADER);
        authorityService.addAuthority(authority);
*/
        Role role = new Role();
        role.setRole("ROLE_TEAM_LEADER");
        
        User user = new User();
        user.setUsername(username);

        user.setPassword(userService.getEncodedPassword(formMap.get("password")
                .toString()));

        user.setEnabled(false);
        //user.setAuthority(authority);
        user.setRole(role);
        userService.addUser(user);

        Leader leader = new Leader();
        leader.setFirstName(formMap.get("firstName").toString());
        leader.setLastName(formMap.get("lastName").toString());
        leader.setBirthday(DateUtil.getDateFromString(formMap.get("birthday")
                .toString()));
        leader.setDocument(formMap.get("document").toString());
        leader.setAddress(formMap.get("address").toString());
        leader.setLicense(formMap.get("license").toString());
        leader.setRegistrationDate(new Date());
        leader.setUser(user);
        leaderDAO.addLeader(leader);

        String to = adminSettingsService.getAdminSettings().getFeedbackEmail();
        String from = to;
        String subject = "Leader registration";
        String message = String.format("Registered a new team leader - %s %s ",
                leader.getFirstName(), leader.getLastName());
        mailService.sendMail(to, from, subject, message);

        LOG.info(String
                .format("Registrated new leader with login %s", username));
    }

}