package net.carting.dao;

import net.carting.domain.Leader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class LeaderDAOImpl implements LeaderDAO {
	
	private static final Logger LOG = LoggerFactory.getLogger(LeaderDAOImpl.class);

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<Leader> getAllLeaders() {
    	LOG.debug("Get all leaders");
        return entityManager
                .createQuery("from Leader ORDER BY registrationDate DESC, lastName, firstName")
                .getResultList();
    }

    @Override
    public Leader getLeaderById(int id) {
    	LOG.debug("Get leader with id = {}", id);
        return (Leader) entityManager
                .createQuery("from Leader where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    public void addLeader(Leader leader) {
        entityManager.persist(leader);
        LOG.debug("Added leader {}", leader);
    }

    @Override
    public void updateLeader(Leader leader) {
        entityManager.merge(leader);
        LOG.debug("Updated leader with id = {}", leader.getId());
    }

    @Override
    public void deleteLeader(Leader leader) {
        Query query = entityManager.createQuery(
                "DELETE FROM Leader c WHERE c.id = :id");
        query.setParameter("id", leader.getId());
        if (query.executeUpdate() != 0) {
        	LOG.debug("Deleted leader with id = {}", leader.getId());
        } else {
        	LOG.warn("Tried to delete leader with id = {}", leader.getId());
        }
    }

    @Override
    public Leader getLeaderByUserName(String username) {    	
    	Query query = entityManager.
                createQuery("FROM Leader WHERE user.username = :username");
        query.setParameter("username", username);
        LOG.debug("Get leader with username = {}", username);
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
