package net.carting.dao;

import net.carting.domain.AdminSettings;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminSettingsDAOImpl implements AdminSettingsDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public AdminSettings getAdminSettings() {
		return (AdminSettings)sessionFactory.getCurrentSession().createQuery("from AdminSettings").list().get(0);
	}

	@Override
	public void updatePerentalPermissionYears(int value) {
		Query query = sessionFactory.getCurrentSession().
				createQuery("UPDATE AdminSettings "
							+ "SET parentalPermissionYears = :parentalPermissionYears");
		query.setParameter("parentalPermissionYears", value);
		query.executeUpdate();
	}

	@Override
	public void updatePointsByPlaces(String value) {
		Query query = sessionFactory.getCurrentSession().
				createQuery("UPDATE AdminSettings "
							+ "SET pointsByPlaces = :pointsByPlaces");
		query.setParameter("pointsByPlaces", value);
		query.executeUpdate();
	}
	
	@Override
	public void updateFeedbackEmail(String value){
		Query query = sessionFactory.getCurrentSession().
				createQuery("UPDATE AdminSettings "
							+ "SET feedbackEmail = :feedbackEmail");
		query.setParameter("feedbackEmail", value);
		query.executeUpdate();
	}

}
