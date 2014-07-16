package net.carting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.carting.dao.AuthorityDAO;
import net.carting.domain.Authority;

@Service
public class AuthorityServiceImpl implements AuthorityService {

	@Autowired
	private AuthorityDAO authorityDAO;

	@Override
	@Transactional
	public Authority getAuthorityByUserName(String username) {
		return authorityDAO.getAuthorityByUserName(username);
	}

	@Override
	@Transactional
	public List<String> getUsersByAuthotity(String authority) {
		return authorityDAO.getUsersByAuthotity(authority);
	}

	@Override
	@Transactional
	public List<Authority> getAllAuthoritys() {
		return authorityDAO.getAllAuthorities();
	}

	@Override
	@Transactional
	public void addAuthority(Authority authority) {
		authorityDAO.addAuthority(authority);

	}

	@Override
	@Transactional
	public void updateAuthority(Authority authority) {
		authorityDAO.updateAuthority(authority);

	}

	@Override
	@Transactional
	public void deleteAuthority(Authority authority) {
		authorityDAO.deleteAuthority(authority);

	}

}
