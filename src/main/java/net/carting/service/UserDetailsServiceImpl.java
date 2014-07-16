package net.carting.service;

import net.carting.dao.UserDAO;
import net.carting.domain.User;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("userDetailsServiceImpl")
public class UserDetailsServiceImpl implements UserDetailsService {

	private static final Logger LOG = Logger
			.getLogger(UserDetailsServiceImpl.class);

	private UserDAO userDAO;

	@Autowired
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	@Override
	@Transactional
	public UserDetails loadUserByUsername(String username) {
		User user = userDAO.getUserByUserName(username);

		if (user == null) {
			String msg = String.format("User %s not found", username);
			LOG.info(msg);
			throw new UsernameNotFoundException(msg);			
		} 
		
		user.setUserAuthorities(userDAO.getAuthoritiesByUserName(username));
		LOG.info(String.format("%s had logged successfully", user.getUsername()));
		return user;
	}
}