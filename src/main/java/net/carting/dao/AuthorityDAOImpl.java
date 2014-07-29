package net.carting.dao;

import net.carting.domain.Authority;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class AuthorityDAOImpl implements AuthorityDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public Authority getAuthorityByUserName(String username) {
        return (Authority) entityManager
                .createQuery("from Authority where username = :username")
                .setParameter("username", username).getSingleResult();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<String> getUsersByAuthority(String authority) {
        return entityManager
                .createQuery("from Authority where authority = :authority")
                .setParameter("authority", authority).getResultList();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Authority> getAllAuthorities() {
        return entityManager.
                createQuery("from Authority").getResultList();
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
        Authority auth = entityManager.find(Authority.class, authority.getUsername());
        entityManager.remove(auth);
    }

}
