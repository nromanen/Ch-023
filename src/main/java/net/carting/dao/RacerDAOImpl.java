package net.carting.dao;

import net.carting.domain.Document;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassNumber;
import net.carting.domain.Team;

import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Set;

@Repository
public class RacerDAOImpl implements RacerDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    @Override
    public List<Racer> getAllRacers() {
        return entityManager.createQuery("from Racer").getResultList();
    }
    
    @Override
    public List<Racer> getBirthdayRacers(Date checkdate){		
    List<Racer> racers = entityManager.createQuery("from Racer").getResultList();
    List<Racer> resultRacers = new ArrayList();    
    for (int i = 0; i < racers.size(); i++)
    {
    	if (checkdate.getMonth() == racers.get(i).getBirthday().getMonth()) {
    		if ((checkdate.getDay()+1 - racers.get(i).getBirthday().getDay() == 0) || 
    				(checkdate.getDay()+1 - racers.get(i).getBirthday().getDay() == 1) || 
    				(checkdate.getDay()+1 - racers.get(i).getBirthday().getDay() == -1)) {
    			resultRacers.add(racers.get(i));
    		}
    	}
    }    	
    
    return resultRacers;
    	
    }
    
    @Override
    public Racer getRacerById(int id) {
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
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateRacer(Racer racer) {
        entityManager.merge(racer);
    }

    @Override
    public void deleteRacer(Racer racer) {
        try {
            Team team = entityManager.find(Team.class, racer.getTeam().getId());
            Racer r = entityManager.find(Racer.class, racer.getId());
            Set<Racer> racers = team.getRacers();
            racers.remove(racer);
            team.setRacers(racers);
            entityManager.merge(team);
            entityManager.remove(r);
        } catch (Exception e) {
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
        return result.size() > 0;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Racer> getListOfRacersWithSetDocumentByDocumentType(
            int documentType) {
        String hql = "from Racer racer JOIN racer.documents document WHERE document.type = :documentType";
        Query query = entityManager.createQuery(hql);
        query.setParameter("documentType", documentType);

        return query.getResultList();
    }

}
