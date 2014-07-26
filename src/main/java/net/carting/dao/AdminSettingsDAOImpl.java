package net.carting.dao;

import net.carting.domain.AdminSettings;

import net.carting.util.EntityManagerUtil;
import org.springframework.stereotype.Repository;

import javax.persistence.Query;

@Repository
public class AdminSettingsDAOImpl implements AdminSettingsDAO {

	@Override
	public AdminSettings getAdminSettings() {
        AdminSettings adminSettings = (AdminSettings)EntityManagerUtil.getEntityManager().createQuery("from AdminSettings").getResultList().get(0);
        EntityManagerUtil.closeTransaction();
		return adminSettings;
	}

	@Override
	public void updateParentalPermissionYears(int value) {
		Query query = EntityManagerUtil.getEntityManager().
				createQuery("UPDATE AdminSettings "
							+ "SET parentalPermissionYears = :parentalPermissionYears");
		query.setParameter("parentalPermissionYears", value);
		query.executeUpdate();
        EntityManagerUtil.closeTransaction();
	}

	@Override
	public void updatePointsByPlaces(String value) {
        Query query = EntityManagerUtil.getEntityManager().
				createQuery("UPDATE AdminSettings "
							+ "SET pointsByPlaces = :pointsByPlaces");
		query.setParameter("pointsByPlaces", value);
		query.executeUpdate();
        EntityManagerUtil.closeTransaction();
	}
	
	@Override
	public void updateFeedbackEmail(String value){
        Query query = EntityManagerUtil.getEntityManager().
				createQuery("UPDATE AdminSettings "
							+ "SET feedbackEmail = :feedbackEmail");
		query.setParameter("feedbackEmail", value);
		query.executeUpdate();
        EntityManagerUtil.closeTransaction();
	}

}
