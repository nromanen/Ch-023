package net.carting.service;

import java.util.List;

import net.carting.domain.Authority;

public interface AuthorityService {
	public Authority getAuthorityByUserName(String username);

	List<String> getUsersByAuthotity(String authority);

	public List<Authority> getAllAuthoritys();

	public void addAuthority(Authority authority);

	public void updateAuthority(Authority authority);

	public void deleteAuthority(Authority authority);

}
