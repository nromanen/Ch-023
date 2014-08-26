package net.carting.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.Qualifying;
import net.carting.domain.Racer;

@Repository
public class QualifyingDAOImpl implements QualifyingDAO {

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
		try{
		entityManager.persist(qualifying);
		} catch (Exception e) {
			e.printStackTrace();
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
		if (qualifyings.size()>0) {
			for(Qualifying q:qualifyings) {
				if (q.getCarClassCompetition().getId()==carClassCompetition.getId()) {
					resultList.add(q);
				}
			}
			if (resultList.size()>0) {
				return resultList;
			}
		}
		return null;
	}
}
