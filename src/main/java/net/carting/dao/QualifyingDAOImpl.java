package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.CarClassCompetition;
import net.carting.domain.Qualifying;

public class QualifyingDAOImpl implements QualifyingDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;
    
	@SuppressWarnings("unchecked")
	@Override
	public List<Qualifying> getAllQualifyings() {
		 return entityManager
	                .createQuery("from Qualifying")
	                .getResultList();
	}

	@Override
	public Qualifying getQualifyingById(int id) {
		// TODO Auto-generated method stub
		return (Qualifying)entityManager.createQuery
				("from Qualifying where id= :id").
				setParameter("id",id).getSingleResult();
	}

	@Override
	public void addQualifying(Qualifying qualifying) {
		String sql = "INSERT INTO qualifying "
				+ "(racer_number,racer_time,racer_place,car_class_id, "
				+ "car_class_competition_id) values "
				+ "(:number, :time, :place, :carId, :compId);";
		Query query = entityManager.createNativeQuery(sql);
		query.setParameter("number", qualifying.getRacerNumber());
		query.setParameter("time", qualifying.getRacer_time());
		query.setParameter("place", qualifying.getRacerPlace());
		query.setParameter("carId", qualifying.getCarClass());
		query.setParameter("compId", qualifying.getCarClassCompetition());
		query.executeUpdate();

	}

	@Override
	public void updateQualifying(Qualifying qualifying) {
		entityManager.merge(qualifying);
	}

	@Override
	public void deleteQualifying(Qualifying qualifying) {
        Query query = entityManager.createQuery(
                "DELETE FROM Race c WHERE c.id = :id");
        query.setParameter("id", qualifying.getId());
        query.executeUpdate();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Qualifying> getQualifyingsByCarClassCompetition(
            CarClassCompetition carClassCompetition) {
		List<Qualifying> qualifyings;
		Query query = entityManager.createQuery("from Race " +
                        "where carClassCompetition = :carClassCompetition " +
                        "order by racerPlace");
        query.setParameter("carClassCompetition", carClassCompetition);
        qualifyings = query.getResultList();
        return qualifyings;
	}

}
