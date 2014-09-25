package net.carting.dao;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.Racer;
import net.carting.domain.Team;
import net.carting.util.DateUtil;

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
        LOG.debug("Racer with (firstName = {}, lastName = {}, birthday = {}) {} exist ", firstName, lastName, birthday, (result.isEmpty() ? "" : "does not"));
        return !result.isEmpty();
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

	@Override
	public List<Racer> getBirthdayRacers(Date checkdate) {
	    LOG.debug("Start of getBirthdayRacers method with input parameter checkdate = {}", checkdate);
		List<Racer> racers = entityManager.createQuery("from Racer").getResultList();
		List<Racer> resultRacers = new ArrayList();
		Calendar cal = Calendar.getInstance();
		cal.setTime(checkdate);
		int checkYear = cal.get(Calendar.YEAR);
		DateUtil dateUtil = new DateUtil();
		int daysInCheckYear = dateUtil.getDaysCount(checkYear);
		int checkday = cal.get(Calendar.DAY_OF_YEAR);
		for (int i = 0; i < racers.size(); i++) {
		cal.setTime(racers.get(i).getBirthday());
		int racerBirthdayYear = cal.get(Calendar.YEAR);
		int daysInRacerBirthdayYear = dateUtil
				.getDaysCount(racerBirthdayYear);
				int birthday = cal.get(Calendar.DAY_OF_YEAR);
				if (daysInCheckYear != daysInRacerBirthdayYear) {
					if (birthday >= 60) {
						birthday = birthday - 1;
					}
				}			
				int dayDifference = checkday - birthday;
				if ((dayDifference == 0) || (dayDifference == 1)
						|| (dayDifference == -1)) {				
					resultRacers.add(racers.get(i));
				}
		 
			}	
		LOG.debug("End of the method getBirthdayRacers. Returned result: {}", resultRacers);
		return resultRacers;
	}

}
