package net.carting.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.carting.domain.Authority;
import net.carting.domain.User;

@Repository
public class UserDAOImpl implements UserDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public User getUserByUserName(String userName) {
		Query query = sessionFactory.getCurrentSession()
				.createQuery("from User where username= :username")
				.setParameter("username", userName);
		return (User) query.uniqueResult();

	}

	@Override
	public List<String> getAuthoritiesByUserName(String userName) {
		User u = (User) sessionFactory.getCurrentSession()
				.createQuery("from User where username= :username")
				.setParameter("username", userName).list().get(0);
		Authority a = u.getAuthority();
		String auth = a.getAuthority();
		List<String> l = new ArrayList<String>();
		l.add(auth);
		return l;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> getAllUsers() {
		return sessionFactory.getCurrentSession().createQuery("from User")
				.list();
	}

	@Override
	public void addUser(User user) {
		sessionFactory.getCurrentSession().save(user);
	}

	@Override
	public void updateUser(User user) {
		sessionFactory.getCurrentSession().merge(user);
	}

	@Override
	public void deleteUser(User user) {
		sessionFactory.getCurrentSession().delete(user);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean isSetUser(String username) {

		List<User> result = sessionFactory.getCurrentSession()
				.createQuery("from User where username = :username")
				.setParameter("username", username).list();

		if (result.size() > 0) {
			return true;
		}
		return false;
	}

	@Override
	public void setEnabled(String username, boolean enabled) {
		Query query = sessionFactory.getCurrentSession().createQuery(
				"UPDATE User SET enabled = :enabled "
						+ "WHERE username = :username");
		query.setBoolean("enabled", enabled);
		query.setString("username", username);
		query.executeUpdate();
	}

}
