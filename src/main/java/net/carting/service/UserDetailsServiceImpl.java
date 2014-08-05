package net.carting.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import net.carting.dao.UserDAO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//@Service("userDetailsServiceImpl")
@Service
@Transactional(readOnly=true)
public class UserDetailsServiceImpl implements UserDetailsService {

    private static final Logger LOG = Logger.getLogger(UserDetailsServiceImpl.class);

    private UserDAO userDAO;

    @Autowired
    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }
    
	@Override
    @Transactional
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		
		net.carting.domain.User domainUser = userDAO.getUserByUserName(username);
		
		if (domainUser == null) {
            String msg = String.format("User %s not found", username);
            LOG.info(msg);
            throw new UsernameNotFoundException(msg);			
		}
		
		boolean enabled = domainUser.isEnabled();
		boolean accountNonExpired = true;
		boolean credentialsNonExpired = true;
		boolean accountNonLocked = true;

		domainUser.setUserAuthorities(userDAO.getAuthoritiesByUserName(username));
        LOG.info(String.format("%s had logged successfully", domainUser.getUsername()));
		return new User (
				domainUser.getUsername(),
				domainUser.getPassword(),
				enabled, 
				accountNonExpired, 
				credentialsNonExpired, 
				accountNonLocked,
				getAuthorities(domainUser.getRole().getId())
		);
	}
	
	public Collection<? extends GrantedAuthority> getAuthorities(Integer role) {
		List<GrantedAuthority> authList = getGrantedAuthorities(getRoles(role));
		return authList;
	}
	
	public List<String> getRoles(Integer role) {

		List<String> roles = new ArrayList<String>();

		if (role.intValue() == 1) {
			roles.add("ROLE_ADMIN");
		} else if (role.intValue() == 2) {
			roles.add("ROLE_TEAM_LEADER");
		}
		return roles;
	}
	
	public static List<GrantedAuthority> getGrantedAuthorities(List<String> roles) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		
		for (String role : roles) {
			authorities.add(new SimpleGrantedAuthority(role));
		}
		return authorities;
	}	
}