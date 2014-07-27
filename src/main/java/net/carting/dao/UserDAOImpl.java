package net.carting.dao;

import net.carting.domain.Authority;
import net.carting.domain.User;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.ArrayList;
import java.util.List;

@Repository
public class UserDAOImpl implements UserDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public User getUserByUserName(String userName) {
        Query query = entityManager
                .createQuery("from User where username= :username")
                .setParameter("username", userName);
        User user = (User) query.getResultList().get(0);

        return user;

    }

    @Override
    public List<String> getAuthoritiesByUserName(String userName) {
        User u = (User) entityManager
                .createQuery("from User where username= :username")
                .setParameter("username", userName).getResultList().get(0);
        Authority a = u.getAuthority();
        String auth = a.getAuthority();
        List<String> l = new ArrayList<String>();
        l.add(auth);

        return l;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<User> getAllUsers() {
        List<User> users = entityManager
                .createQuery("from User").getResultList();

        return users;
    }

    @Override
    public void addUser(User user) {
        entityManager.persist(user);

    }

    @Override
    public void updateUser(User user) {
        entityManager.merge(user);

    }

    @Override
    public void deleteUser(User user) {
        entityManager.remove(user);

    }

    @SuppressWarnings("unchecked")
    @Override
    public boolean isSetUser(String username) {

        List<User> result = entityManager
                .createQuery("from User where username = :username")
                .setParameter("username", username).getResultList();


        return result.size() > 0;
    }

    @Override
    public void setEnabled(String username, boolean enabled) {
        Query query = entityManager.createQuery(
                "UPDATE User SET enabled = :enabled "
                        + "WHERE username = :username");
        query.setParameter("enabled", enabled);
        query.setParameter("username", username);
        query.executeUpdate();

    }

}
