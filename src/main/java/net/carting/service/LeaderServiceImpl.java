package net.carting.service;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.List;

import net.carting.dao.LeaderDAO;
import net.carting.domain.Leader;
import net.carting.domain.User;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LeaderServiceImpl implements LeaderService {
    
	private static final Logger LOG = LoggerFactory.getLogger(LeaderServiceImpl.class);
	
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

    @Override
    @Transactional
    public void registerLeader(Leader leader)
            throws NoSuchAlgorithmException, UnsupportedEncodingException {

    	User user = leader.getUser();
		user.setPassword(userService.getEncodedPassword(user.getPassword()));
    	user.setEnabled(false);
    	user.setRole(roleService.getRole(UserService.ROLE_TEAM_LEADER_ID));        

    	leader.setUser(user);
    	leader.setRegistrationDate(new Date());
        leaderDAO.addLeader(leader);
        
        String email = leader.getUser().getEmail();
        String username = leader.getUser().getUsername();
        
        String to = email;
        String from = adminSettingsService.getAdminSettings().getFeedbackEmail();
        String subject = "Welcome to Carting";
        String message = String.format("Dear %s %s, welcome to Carting, please wait the confirmation of your account ",
                leader.getFirstName(), leader.getLastName());
        mailService.sendMail(to, from, subject, message);
        LOG.debug("Sent message to leader about his registration");
        
        to = adminSettingsService.getAdminSettings().getFeedbackEmail();
        subject = "Leader registration";
        message = String.format("Registered a new team leader - %s %s ",
                leader.getFirstName(), leader.getLastName());
        mailService.sendMail(to, from, subject, message);
        LOG.debug("Sent message to leader about his registration");

        LOG.trace("Registrated new leader with login {}", username);
    }

}