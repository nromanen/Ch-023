package net.carting.dao;

import net.carting.domain.Leader;
import net.carting.domain.Team;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
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
        List<Team> teams = entityManager.createQuery("FROM Team").getResultList();

        return teams;
    }

    @Override
    public Team getTeamById(int id) {
        Team team = (Team) entityManager
                .createQuery("from Team where id = :id")
                .setParameter("id", id)
                .getResultList()
                .get(0);

        return team;
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
        entityManager.remove(team);

    }

    @Override
    public boolean isSetTeam(String teamName) {
        String hql = "FROM Team WHERE name = ?";
        Query query = entityManager.createQuery(hql).setParameter(0, teamName);

        Team result = (Team) query.getResultList().get(0);


        return result != null;
    }

    @Override
    public Team getTeamByLeader(Leader leader) {
        Query query = entityManager
                .createQuery("FROM Team WHERE leader = :leader")
                .setParameter("leader", leader);
        Team team = (Team) query.getResultList().get(0);

        return team;
    }

    @Override
    public boolean isTeamByLeaderId(int leaderId) {
        Query query = entityManager.createQuery("FROM Team WHERE leader.id = :leaderId");
        query.setParameter("leaderId", leaderId);

        Team result = (Team) query.getResultList().get(0);


        return result != null;
    }

}
