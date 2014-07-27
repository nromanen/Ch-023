package net.carting.dao;

import net.carting.domain.Authority;

import java.util.List;

public interface AuthorityDAO {

    public Authority getAuthorityByUserName(String username);

    List<String> getUsersByAuthority(String authority);

    public List<Authority> getAllAuthorities();

    public void addAuthority(Authority authority);

    public void updateAuthority(Authority authority);

    public void deleteAuthority(Authority authority);

}
