package net.carting.dao;

import net.carting.domain.CarClass;
import net.carting.domain.RacerCarClassNumber;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;


@Repository
public class RacerCarClassNumberDAOImpl implements RacerCarClassNumberDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<RacerCarClassNumber> getAllRacerCarClassNumbers() {
		return sessionFactory.getCurrentSession().createQuery("from RacerCarClassNumber").list();
	}

	@Override
	public RacerCarClassNumber getRacerCarClassNumberById(int id) {
		return (RacerCarClassNumber) sessionFactory.getCurrentSession().get(RacerCarClassNumber.class, id);
	}

	@Override
	public void addCarClass(RacerCarClassNumber racerCarClassNumber) {
		sessionFactory.getCurrentSession().save(racerCarClassNumber);
	}

	@Override
	public void updateCarClass(RacerCarClassNumber racerCarClassNumber) {
		sessionFactory.getCurrentSession().merge(racerCarClassNumber);
	}

	@Override
	public void deleteCarClass(RacerCarClassNumber racerCarClassNumber) {
		sessionFactory.getCurrentSession().delete(racerCarClassNumber);
	}

	@Override
	public List<RacerCarClassNumber> getNumbersByCarClass(CarClass carClass) {
		Query query = sessionFactory.getCurrentSession().createQuery("from RacerCarClassNumber where carClass= :carClass ").setParameter("carClass",carClass);
		return (ArrayList<RacerCarClassNumber>) query.list();
	}
	
	public List<RacerCarClassNumber> getNumbersByCarClassId(int carClassId){
		Query query = sessionFactory.getCurrentSession()
				.createQuery("from RacerCarClassNumber where carClass.id = :carClassId ")
				.setParameter("carClassId", carClassId);
		return (List<RacerCarClassNumber>) query.list();
	}
	
	@Override
	public boolean isSetRacerCarClassNumberByCarClassIdAndNumber(int carClassId, int number){
		Query query = sessionFactory.getCurrentSession().
					  createSQLQuery("SELECT * FROM racer_car_class_numbers "
					  				+ "WHERE car_class_id = :car_class_id AND "
					  				+ "number = :number").
					  addEntity(RacerCarClassNumber.class);
		query.setString("car_class_id", Integer.toString(carClassId));
		query.setString("number", Integer.toString(number));
		List result = query.list();
		
		if(result.size() > 0){
			return true;
		}
		return false;
	}

    @Override
    public RacerCarClassNumber getRacerCarClassNumberByCarClassIdAndRacer(int carClassId, int racerId){
        Query query = sessionFactory.getCurrentSession().
                createQuery("FROM RacerCarClassNumber rccn "
                        + "WHERE rccn.carClass.id = :carClassId AND "
                        + "rccn.racer.id = :racerId");
        query.setParameter("carClassId", carClassId);
        query.setParameter("racerId", racerId);
        return (RacerCarClassNumber)query.uniqueResult();
    }
    
	@Override
	public boolean isSetCarClassByCarClassIdAndRacerId(int carClassId, int racerId) {
		String sqlQuery = "SELECT * FROM racer_car_class_numbers WHERE car_class_id = :carClassId AND racer_id = :racerId";
		Query query = sessionFactory
				.getCurrentSession()
				.createSQLQuery(sqlQuery).
		setParameter("carClassId", carClassId).
		setParameter("racerId", racerId);
		List result = query.list();

		if (result.size() > 0) {
			return true;
		}		
		return false;		
	}

}
