package net.carting.dao;

import net.carting.domain.Leader;
import net.carting.domain.Team;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class TeamDAOImpl implements TeamDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<Team> getAllTeams() {
        return entityManager.createQuery("FROM Team").getResultList();
    }

    @Override
    public Team getTeamById(int id) {
        return (Team) entityManager
                .createQuery("from Team where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);
    }

    public void addTeam(Team team) {
        entityManager.persist(team);
    }

    @Override
    public void updateTeam(Team team) {
        entityManager.merge(team);
    }

    @Override
    public void deleteTeam(Team team) {
        Query query = entityManager.createQuery(
                "DELETE FROM Team c WHERE c.id = :id");
        query.setParameter("id", team.getId());
        query.executeUpdate();
    }

    @Override
    public boolean isSetTeam(String teamName) {
        String hql = "FROM Team WHERE name = :name";
        Query query = entityManager.createQuery(hql).setParameter("name", teamName);
        Team result = (Team) query.getResultList().get(0);
        return result != null;
    }

    @Override
    public Team getTeamByLeader(Leader leader) {
        Query query = entityManager
                .createQuery("FROM Team WHERE leader = :leader")
                .setParameter("leader", leader);
        return (Team) query.getResultList().get(0);
    }

    @Override
    public boolean isTeamByLeaderId(int leaderId) {
        Query query = entityManager.createQuery("FROM Team WHERE leader.id = :leaderId");
        query.setParameter("leaderId", leaderId);
        try {
            query.getSingleResult();
        } catch (NoResultException e) {
            return false;
        }
        return true;
    }

}
