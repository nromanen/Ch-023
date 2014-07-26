package net.carting.dao;

import java.util.List;

import net.carting.util.EntityManagerUtil;
import org.springframework.stereotype.Repository;

import net.carting.domain.Authority;

@Repository
public class AuthorityDAOImpl implements AuthorityDAO {

	@Override
	public Authority getAuthorityByUserName(String username) {
        Authority authority = (Authority) EntityManagerUtil.getEntityManager()
				.createQuery("from Authority where username = :username")
				.setParameter("username", username).getResultList().get(0);
        EntityManagerUtil.closeTransaction();
        return authority;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<String> getUsersByAuthority(String authority) {
        List<String> stringList = EntityManagerUtil.getEntityManager()
				.createQuery("from Authority where authority = :authority")
				.setParameter("authority", authority).getResultList();
        EntityManagerUtil.closeTransaction();
        return  stringList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Authority> getAllAuthorities() {
        List<Authority> authorities = EntityManagerUtil.getEntityManager().
                createQuery("from Authority").getResultList();
        EntityManagerUtil.closeTransaction();
        return  authorities;
	}

	@Override
	public void addAuthority(Authority authority) {
        EntityManagerUtil.getEntityManager().persist(authority);
        EntityManagerUtil.closeTransaction();
	}

	@Override
	public void updateAuthority(Authority authority) {
        EntityManagerUtil.getEntityManager().merge(authority);
        EntityManagerUtil.closeTransaction();
	}

	@Override
	public void deleteAuthority(Authority authority) {
        EntityManagerUtil.getEntityManager().remove(authority);
        EntityManagerUtil.closeTransaction();
	}

}
