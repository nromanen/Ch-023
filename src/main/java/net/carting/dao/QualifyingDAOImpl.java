package net.carting.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.Qualifying;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class QualifyingDAOImpl implements QualifyingDAO {
    
    private static final Logger LOG = LoggerFactory.getLogger(QualifyingDAOImpl.class);

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;
    
	@SuppressWarnings("unchecked")
	@Override
	public List<Qualifying> getAllQualifyings() {
		 return entityManager
	                .createQuery("from Qualifying order by car_class_competition_id,racer_place")
	                .getResultList();
	}

	@Override
	public Qualifying getQualifyingById(int id) {
		return (Qualifying)entityManager.createQuery
				("from Qualifying where id= :id").
				setParameter("id",id).getSingleResult();
	}

	@Override
	public void addQualifying(Qualifying qualifying) {
		try {
		    entityManager.persist(qualifying);
		} catch (Exception e) {
			LOG.error("Errors in addQualifying method", e);
		}
	}

	@Override
	public void updateQualifying(Qualifying qualifying) {
		entityManager.merge(qualifying);
	}

	@Override
	public void deleteQualifying(Qualifying qualifying) {
		CarClassCompetition ccc = entityManager.find(CarClassCompetition.class,qualifying.getCarClassCompetition().getId());
		Qualifying q = entityManager.find(Qualifying.class, qualifying.getId());
		Set<Qualifying>ques = ccc.getQualifyings();
		ques.remove(qualifying);
		ccc.setQualifyings(ques);
		entityManager.merge(ccc);
		entityManager.remove(q);
	}

	@Override
	public List<Qualifying> getQualifyingsByCarClassCompetition(
            CarClassCompetition carClassCompetition) {
		
		List<Qualifying> qualifyings = getAllQualifyings();
		List<Qualifying> resultList = new ArrayList<Qualifying>();
		if (!qualifyings.isEmpty()) {
			for(Qualifying q:qualifyings) {
				if (q.getCarClassCompetition().getId()==carClassCompetition.getId()) {
					resultList.add(q);
				}
			}
			if (!resultList.isEmpty()) {
				return resultList;
			}
		}
		return null;
	}
}
