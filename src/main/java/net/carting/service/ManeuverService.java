package net.carting.service;

import net.carting.domain.Maneuver;

import java.util.List;

/**
 * Created by manson on 9/2/14.
 */
public interface ManeuverService {

    List<Maneuver> getAllManeuvers();

    Maneuver getManeuverById(int id);

    void deleteManeuver(Maneuver maneuver);

    void deleteManeuver(int id);

    void addManeuver(Maneuver maneuver);

    void updateManeuver(Maneuver maneuver);

}
