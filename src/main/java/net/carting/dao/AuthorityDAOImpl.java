package net.carting.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.carting.domain.Authority;

@Repository
public class AuthorityDAOImpl implements AuthorityDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public Authority getAuthorityByUserName(String username) {
		return (Authority) sessionFactory.getCurrentSession()
				.createQuery("from Authority where username = :username")
				.setParameter("username", username).uniqueResult();

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<String> getUsersByAuthotity(String authority) {
		return sessionFactory.getCurrentSession()
				.createQuery("from Authority where authority = :authority")
				.setParameter("authority", authority).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Authority> getAllAuthorities() {
		return sessionFactory.getCurrentSession().createQuery("from Authority")
				.list();
	}

	@Override
	public void addAuthority(Authority authority) {
		sessionFactory.getCurrentSession().save(authority);
	}

	@Override
	public void updateAuthority(Authority authority) {
		sessionFactory.getCurrentSession().merge(authority);
	}

	@Override
	public void deleteAuthority(Authority authority) {
		sessionFactory.getCurrentSession().delete(authority);

	}

}
