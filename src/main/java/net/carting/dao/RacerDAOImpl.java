package net.carting.dao;

import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.Racer;
import net.carting.domain.Team;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class RacerDAOImpl implements RacerDAO {

	private static final Logger LOG = LoggerFactory.getLogger(RacerDAOImpl.class);
	
    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<Racer> getAllRacers() {
    	LOG.debug("Get all racers");
        return entityManager.createQuery("from Racer").getResultList();
    }

    @Override
    public Racer getRacerById(int id) {
    	LOG.debug("Get racer with id = {}", id);
        return (Racer) entityManager
                .createQuery("from Racer where id = :id")
                .setParameter("id", id)
                .getSingleResult();
    }

    @Override
    public void addRacer(Racer racer) {
        try {
            Team team = entityManager.find(Team.class, racer.getTeam().getId());
            Set<Racer> racers = team.getRacers();
            racers.add(racer);
            team.setRacers(racers);
            entityManager.persist(racer);
            entityManager.merge(team);
            LOG.debug("Added racer {}", racer);
        } catch (Exception e) {
            LOG.error("Tried to add racer {}", racer, e);
        }
    }

    @Override
    public void updateRacer(Racer racer) {
        entityManager.merge(racer);
        LOG.debug("Updated racer with id = {}", racer.getId());
    }

    @Override
    public void deleteRacer(Racer racer) {
        try {
            Team team = entityManager.find(Team.class, racer.getTeam().getId());
            Racer r = entityManager.find(Racer.class, racer.getId());
            Set<Racer> racers = team.getRacers();
            racers.remove(racer);
            LOG.debug("Removed racer(id = {}) from team(id = {})", racer.getId(), team.getId());
            team.setRacers(racers);
            entityManager.merge(team);
            entityManager.remove(r);
            LOG.debug("Deleted racer with id = {}", racer.getId());
        } catch (Exception e) {
        	LOG.error("Tried to delete racer with id = {} but error has occured", racer.getId());
            e.printStackTrace();
        }
    }

    @Override
    public boolean isSetRacer(String firstName, String lastName, Date birthday) {
        String hql = "from Racer r where r.firstName= :firstName and r.lastName= :lastName and r.birthday= :birthday";
        Query query = entityManager.createQuery(hql)
                .setParameter("firstName", firstName)
                .setParameter("lastName", lastName)
                .setParameter("birthday", birthday);
        List result = query.getResultList();
        LOG.debug("Racer with (firstName = {}, lastName = {}, birthday = {}) {} exist ", firstName, lastName, birthday, (result.size() > 0 ? "" : "does not"));
        return result.size() > 0;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Racer> getListOfRacersWithSetDocumentByDocumentType(
            int documentType) {
        String hql = "from Racer racer JOIN racer.documents document WHERE document.type = :documentType";
        Query query = entityManager.createQuery(hql);
        query.setParameter("documentType", documentType);
        LOG.debug("Get racers with documents(documentType = {})", documentType);
        return query.getResultList();
    }

}
