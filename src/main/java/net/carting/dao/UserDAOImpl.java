package net.carting.dao;

import net.carting.domain.Role;
import net.carting.domain.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.ArrayList;
import java.util.List;

@Repository
public class UserDAOImpl implements UserDAO {
	
	private static final Logger LOG = LoggerFactory.getLogger(UserDAOImpl.class);

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public User getUserByUserName(String userName) {
        Query query = entityManager
                .createQuery("from User where username= :username")
                .setParameter("username", userName);
        try {
        	User user = (User) query.getSingleResult();
        	LOG.debug("Get user(userName = {})", userName);
            return user;
        } catch (NoResultException e) {
        	LOG.error("Tried to get user(userName = {})", userName,e);
            return null;
        }
    }
    
    @Override
    public User getUserByEmail(String email) {
        Query query = entityManager
                .createQuery("from User where email= :email")
                .setParameter("email", email);
        try {
        	User user = (User) query.getSingleResult();
        	LOG.debug("Get user(email = {})", email);
            return user;
        } catch (NoResultException e) {
        	LOG.error("Tried to get user(email = {})", email, e);
            return null;
        }
    }

    @Override
    public List<String> getAuthoritiesByUserName(String userName) {
        User u = (User) entityManager
                .createQuery("from User where username= :username")
                .setParameter("username", userName).getSingleResult();
        Role r = u.getRole();
        String auth = r.getRole();
        List<String> l = new ArrayList<String>();
        l.add(auth);
        LOG.debug("Get authority for user(userName = {})", userName);
        return l;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<User> getAllUsers() {
    	LOG.debug("Get all users");
        return entityManager.createQuery("from User").getResultList();
    }

    @Override
    public void addUser(User user) {
        entityManager.persist(user);
        LOG.debug("Add user {}", user);
    }

    @Override
    public void updateUser(User user) {
        entityManager.merge(user);
        LOG.debug("Update user(username = {})", user.getUsername());
    }

    @Override
    public void deleteUser(User user) {
        Query query = entityManager.createQuery(
                "DELETE FROM User u WHERE u.username = :name");
        query.setParameter("name", user.getUsername());
        if (query.executeUpdate() != 0) {
        	LOG.debug("Deleted user(username = {})",user.getUsername());
        } else {
        	LOG.warn("Tried to delete user(username = {})",user.getUsername());
        }
        
    }

    @SuppressWarnings("unchecked")
    @Override
    public boolean isSetUser(String username) {
        List<User> result = entityManager
                .createQuery("from User where username = :username")
                .setParameter("username", username).getResultList();
        LOG.debug("User(username = {}) {} exist", username, (result.size() > 0 ? "" : "does not"));
        return result.size() > 0;
    }
    
    @SuppressWarnings("unchecked")
    @Override
    public boolean isSetEmail(String email) {
        List<User> result = entityManager
                .createQuery("from User where email = :email")
                .setParameter("email", email).getResultList();
        LOG.debug("User(email = {}) {} exist", email, (result.size() > 0 ? "" : "does not"));
        return result.size() > 0;
    }

    @Override
    public void setEnabled(String username, boolean enabled) {
        Query query = entityManager.createQuery(
                "UPDATE User SET enabled = :enabled "
                        + "WHERE username = :username");
        query.setParameter("enabled", enabled);
        query.setParameter("username", username);
        if (query.executeUpdate() != 0) {
        	LOG.debug("User(username = {}) set to {}", username, (enabled ? "enabled" : "disabled"));
        } else {
        	LOG.debug("User(username = {}) tried to set to {}", username, (enabled ? "enabled" : "disabled"));
        }
    }
}
