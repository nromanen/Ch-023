package net.carting.dao;

import net.carting.domain.Leader;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class LeaderDAOImpl implements LeaderDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public List<Leader> getAllLeaders() {
        List<Leader> leaders = entityManager
                .createQuery("from Leader ORDER BY registrationDate DESC, lastName, firstName")
                .getResultList();

        return leaders;
    }

    @Override
    public Leader getLeaderById(int id) {
        Leader lead = (Leader) entityManager
                .createQuery("from Leader where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);

        return lead;
    }

    public void addLeader(Leader leader) {
        entityManager.persist(leader);

    }

    @Override
    public void updateLeader(Leader leader) {
        entityManager.merge(leader);

    }

    @Override
    public void deleteLeader(Leader leader) {
        entityManager.remove(leader);

    }

    @Override
    public Leader getLeaderByUserName(String username) {
        Query query = entityManager.
                createQuery("FROM Leader WHERE user.username = :username");
        query.setParameter("username", username);
        Leader lead = (Leader) query.getResultList().get(0);

        return lead;
    }

}
