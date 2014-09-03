package net.carting.service;

import net.carting.dao.ManeuverDAO;
import net.carting.domain.Maneuver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

/**
 * Created by manson on 9/2/14.
 */
@Service
public class ManeuverServiceImpl implements ManeuverService {

    @Autowired
    ManeuverDAO maneuverDAO;

    @Override
    @Transactional
    public List<Maneuver> getAllManeuvers() {
        return maneuverDAO.getAllManeuvers();
    }

    @Override
    @Transactional
    public Maneuver getManeuverById(int id) {
        return maneuverDAO.getManeuverById(id);
    }

    @Override
    @Transactional
    public void deleteManeuver(Maneuver maneuver) {
        maneuverDAO.deleteManeuver(maneuver);
    }

    @Override
    @Transactional
    public void deleteManeuver(int id) {
        maneuverDAO.deleteManeuver(id);
    }

    @Override
    @Transactional
    public void addManeuver(Maneuver maneuver) {
        maneuverDAO.addManeuver(maneuver);
    }

    @Override
    @Transactional
    public void updateManeuver(Maneuver maneuver) {
        maneuverDAO.updateManeuver(maneuver);
    }
}
