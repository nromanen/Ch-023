package net.carting.dao;

import net.carting.domain.Authority;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class AuthorityDAOImpl implements AuthorityDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public Authority getAuthorityByUserName(String username) {
        Authority authority = (Authority) entityManager
                .createQuery("from Authority where username = :username")
                .setParameter("username", username).getResultList().get(0);
        return authority;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<String> getUsersByAuthority(String authority) {
        List<String> stringList = entityManager
                .createQuery("from Authority where authority = :authority")
                .setParameter("authority", authority).getResultList();
        return stringList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Authority> getAllAuthorities() {
        List<Authority> authorities = entityManager.
                createQuery("from Authority").getResultList();
        return authorities;
    }

    @Override
    public void addAuthority(Authority authority) {
        entityManager.persist(authority);
    }

    @Override
    public void updateAuthority(Authority authority) {
        entityManager.merge(authority);
    }

    @Override
    public void deleteAuthority(Authority authority) {
        entityManager.remove(authority);
    }

}
