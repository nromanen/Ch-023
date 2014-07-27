package net.carting.dao;

import net.carting.domain.AdminSettings;

import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

@Repository
public class AdminSettingsDAOImpl implements AdminSettingsDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

	@Override
	public AdminSettings getAdminSettings() {
        AdminSettings adminSettings = (AdminSettings) entityManager.createQuery("from AdminSettings").getResultList().get(0);
		return adminSettings;
	}

	@Override
	public void updateParentalPermissionYears(int value) {
		Query query = entityManager.
				createQuery("UPDATE AdminSettings "
							+ "SET parentalPermissionYears = :parentalPermissionYears");
		query.setParameter("parentalPermissionYears", value);
		query.executeUpdate();
	}

	@Override
	public void updatePointsByPlaces(String value) {
        Query query = entityManager
                .createQuery("UPDATE AdminSettings "
							+ "SET pointsByPlaces = :pointsByPlaces");
		query.setParameter("pointsByPlaces", value);
		query.executeUpdate();
	}
	
	@Override
	public void updateFeedbackEmail(String value){
        Query query = entityManager
                .createQuery("UPDATE AdminSettings "
							+ "SET feedbackEmail = :feedbackEmail");
		query.setParameter("feedbackEmail", value);
		query.executeUpdate();
	}

}
