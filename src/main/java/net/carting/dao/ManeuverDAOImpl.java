package net.carting.dao;

import net.carting.domain.Maneuver;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

/**
 * Created by manson on 9/2/14.
 */
@Repository
public class ManeuverDAOImpl implements ManeuverDAO {

    @PersistenceContext(unitName = "entityManager")
    private EntityManager entityManager;

    @Override
    public List<Maneuver> getAllManeuvers() {
        return entityManager.createQuery("from Maneuver").getResultList();
    }

    @Override
    public Maneuver getManeuverById(int id) {
        return entityManager.find(Maneuver.class, id);
    }

    @Override
    public void deleteManeuver(Maneuver maneuver) {
        entityManager.remove(maneuver);
    }

    @Override
    public void deleteManeuver(int id) {
        Maneuver maneuver = entityManager.find(Maneuver.class, id);
        entityManager.remove(maneuver);
    }

    @Override
    public void addManeuver(Maneuver maneuver) {
        entityManager.persist(maneuver);
    }

    @Override
    public void updateManeuver(Maneuver maneuver) {
        entityManager.merge(maneuver);
    }
}
