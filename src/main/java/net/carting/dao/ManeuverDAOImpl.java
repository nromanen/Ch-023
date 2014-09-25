package net.carting.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import net.carting.domain.Maneuver;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * Created by manson on 9/2/14.
 */
@Repository
public class ManeuverDAOImpl implements ManeuverDAO {
    
    private static final Logger LOG = LoggerFactory.getLogger(ManeuverDAOImpl.class);

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public List<Maneuver> getAllManeuvers() {
        LOG.debug("Get all maneuvers");
        return entityManager.createQuery("from Maneuver").getResultList();
    }

    @Override
    public Maneuver getManeuverById(int id) {
        LOG.debug("Get maneuver by id = {}", id);
        return entityManager.find(Maneuver.class, id);
    }

    @Override
    public void deleteManeuver(Maneuver maneuver) {
        entityManager.remove(maneuver);
        LOG.debug("Deleted maneuver {}", maneuver);
    }

    @Override
    public void deleteManeuver(int id) {
        Maneuver maneuver = entityManager.find(Maneuver.class, id);
        entityManager.remove(maneuver);
        LOG.debug("Deleted maneuver with id = {}", id);
    }

    @Override
    public void addManeuver(Maneuver maneuver) {
        entityManager.persist(maneuver);
        LOG.debug("Added maneuver {}", maneuver);
    }

    @Override
    public void updateManeuver(Maneuver maneuver) {
        entityManager.merge(maneuver);
        LOG.debug("Updated maneuver {}", maneuver);
    }
}
