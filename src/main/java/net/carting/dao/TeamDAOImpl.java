package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.Leader;
import net.carting.domain.Team;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class TeamDAOImpl implements TeamDAO {
	
	private static final Logger LOG = LoggerFactory.getLogger(TeamDAOImpl.class);

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<Team> getAllTeams() {
    	LOG.debug("Get all teams");
        return entityManager.createQuery("FROM Team").getResultList();
    }

    @Override
    public Team getTeamById(int id) {
    	LOG.debug("Get team with id = {}", id);
        return (Team) entityManager
                .createQuery("from Team where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    public void addTeam(Team team) {
        entityManager.persist(team);
        LOG.debug("Added team {}", team);
    }

    @Override
    public void updateTeam(Team team) {
        entityManager.merge(team);
        LOG.debug("Updated team with id = {}", team.getId());
    }

    @Override
    public void deleteTeam(Team team) {
        Query query = entityManager.createQuery(
                "DELETE FROM Team c WHERE c.id = :id");
        query.setParameter("id", team.getId());
        if (query.executeUpdate() != 0) {
        	LOG.debug("Deleted team with id = {}", team.getId());
        } else {
        	LOG.warn("Tried to delete team with id = {}", team.getId());
        }
    }

    @Override
    public boolean isSetTeam(String teamName) {
        String hql = "FROM Team WHERE name = :name";
        Query query = entityManager.createQuery(hql).setParameter("name", teamName);
        Team result = null;
        try {
            result = (Team) query.getSingleResult();
            LOG.debug("Team {} {} exist", teamName, (result != null ? "" : "does not"));
        } catch (NoResultException e) {
            return false;
        }
        return result != null;
    }

    @Override
    public Team getTeamByLeader(Leader leader) {
        Query query = entityManager
                .createQuery("FROM Team WHERE leader = :leader")
                .setParameter("leader", leader);
        LOG.debug("Get team by leader with id = {}", leader.getId());
        return (Team) query.getSingleResult();
    }

    @Override
    public boolean isTeamByLeaderId(int leaderId) {
        Query query = entityManager.createQuery("FROM Team WHERE leader.id = :leaderId");
        query.setParameter("leaderId", leaderId);
        try {
            query.getSingleResult();
        } catch (NoResultException e) {
        	LOG.debug("Leader(id = {}) has not team", leaderId);
            return false;
        }
        LOG.debug("Leader(id = {}) has team", leaderId);
        return true;
    }

}
