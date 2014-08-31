package net.carting.dao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.carting.domain.AdminSettings;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class AdminSettingsDAOImpl implements AdminSettingsDAO {

    private static final Logger LOG = LoggerFactory.getLogger(AdminSettingsDAOImpl.class);

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public AdminSettings getAdminSettings() {
        LOG.debug("Getting admin settings from DB");
        return (AdminSettings) entityManager.createQuery("from AdminSettings").getSingleResult();
    }

    @Override
    public void updateParentalPermissionYears(int value) {
        Query query = entityManager.
                createQuery("UPDATE AdminSettings "
                        + "SET parentalPermissionYears = :parentalPermissionYears");
        query.setParameter("parentalPermissionYears", value);
        query.executeUpdate();
        LOG.debug("Changed parental permission years to {}", value);
    }

    @Override
    public void updatePointsByPlaces(String value) {
        Query query = entityManager
                .createQuery("UPDATE AdminSettings "
                        + "SET pointsByPlaces = :pointsByPlaces");
        query.setParameter("pointsByPlaces", value);
        query.executeUpdate();
        LOG.debug("Changed points_by_places in admin settings to {}", value);
    }

    @Override
    public void updateFeedbackEmail(String value) {
        Query query = entityManager
                .createQuery("UPDATE AdminSettings "
                        + "SET feedbackEmail = :feedbackEmail");
        query.setParameter("feedbackEmail", value);
        query.executeUpdate();
        LOG.debug("Changed feedback email to {}", value);
    }

}
