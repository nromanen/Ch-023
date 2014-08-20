package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.Leader;

import org.springframework.stereotype.Repository;

@Repository
public class LeaderDAOImpl implements LeaderDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<Leader> getAllLeaders() {
        return entityManager
                .createQuery("from Leader ORDER BY registrationDate DESC, lastName, firstName")
                .getResultList();
    }

    @Override
    public Leader getLeaderById(int id) {
        return (Leader) entityManager
                .createQuery("from Leader where id = :id")
                .setParameter("id", id)
                .getSingleResult();
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
        Query query = entityManager.createQuery(
                "DELETE FROM Leader c WHERE c.id = :id");
        query.setParameter("id", leader.getId());
        query.executeUpdate();
    }

    @Override
    public Leader getLeaderByUserName(String username) {    	
    	Query query = entityManager.
                createQuery("FROM Leader WHERE user.username = :username");
        query.setParameter("username", username);
        return (Leader) query.getSingleResult();
    }

    /*
	@Override
	public Leader getLeaderByUserId(int userId) {
        Query query = entityManager.
                createQuery("FROM Leader WHERE user.id = :userId");
        query.setParameter("username", userId);
        return (Leader) query.getSingleResult();		
	}
	*/

}
