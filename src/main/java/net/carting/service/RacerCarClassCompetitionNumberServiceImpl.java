package net.carting.service;

import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.carting.dao.RacerCarClassCompetitionNumberDAO;
import net.carting.dao.TeamInCompetitionDAO;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Competition;
import net.carting.domain.Racer;
import net.carting.domain.RacerCarClassCompetitionNumber;
import net.carting.domain.Team;
import net.carting.domain.TeamInCompetition;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class RacerCarClassCompetitionNumberServiceImpl implements RacerCarClassCompetitionNumberService {

    @Autowired
    private RacerCarClassCompetitionNumberDAO racerCarClassCompetitionNumberDAO;

    @Autowired
    private TeamInCompetitionDAO teamInCompetitionDAO;

    @Autowired
    private RacerService racerService;

    @Autowired
    private CarClassCompetitionService carClassCompetitionService;

    private static final Logger LOG = LoggerFactory.getLogger(RacerCarClassCompetitionNumberServiceImpl.class);

    @Override
    @Transactional
    public List<RacerCarClassCompetitionNumber> getAllRacerCarClassCompetitionNumbers() {
        return racerCarClassCompetitionNumberDAO.getAllRacerCarClassCompetitionNumbers();
    }

    @Override
    @Transactional
    public void addRacerCarClassCompetitionNumber(RacerCarClassCompetitionNumber racerCarClassCompetitionNumber) {
        Team team = racerCarClassCompetitionNumber.getRacer().getTeam();
        Competition competition = racerCarClassCompetitionNumber.getCarClassCompetition().getCompetition();
        if (!teamInCompetitionDAO.isTeamInCompetition(team.getId(), competition.getId())) {
            TeamInCompetition teamInCompetition = new TeamInCompetition();
            teamInCompetition.setCompetition(competition);
            teamInCompetition.setTeam(team);
            teamInCompetitionDAO.addTeamInCompetition(teamInCompetition);
            LOG.trace("Team {} (id = {}) has registered on competition {} (id = {})",team.getName(),team.getId(), 
            																		competition.getName(), competition.getId());
        }
        racerCarClassCompetitionNumberDAO.addRacerCarClassCompetitionNumber(racerCarClassCompetitionNumber);
    }

    @Override
    @Transactional
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCarClassCompetitionId(int id) {
        return racerCarClassCompetitionNumberDAO.getRacerCarClassCompetitionNumbersByCarClassCompetitionId(id);
    }

    @Override
    @Transactional
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCarClassCompetitionIdAndTeamId(int carClassCompetitionid, int teamId) {
        return racerCarClassCompetitionNumberDAO.getRacerCarClassCompetitionNumbersByCarClassCompetitionIdAndTeamId(carClassCompetitionid, teamId);
    }

    @Override
    @Transactional
    public int getRacerCarClassCompetitionNumbersCountByCarClassCompetitionId(int id) {
        return racerCarClassCompetitionNumberDAO.getRacerCarClassCompetitionNumbersCountByCarClassCompetitionId(id);
    }

    @Override
    @Transactional
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCompetitionId(int id) {
        return racerCarClassCompetitionNumberDAO.getRacerCarClassCompetitionNumbersByCompetitionId(id);
    }

    @Override
    @Transactional
    public void deleteByCarClassCompetitionIdAndRacerId(int carClassCompetitonId, int racerId) {
        racerCarClassCompetitionNumberDAO.deleteByCarClassCompetitionIdAndRacerId(carClassCompetitonId, racerId);
    }

    @Override
    @Transactional
    public void deleteByCompetitionIdAndRacerId(int competitonId, int racerId) {
        racerCarClassCompetitionNumberDAO.deleteByCompetitionIdAndRacerId(competitonId, racerId);
    }

    @Override
    @Transactional
    public List<RacerCarClassCompetitionNumber>
    getRacerCarClassCompetitionNumbersByCompetitionIdAndTeamId(int competitionId, int teamId) {
        return racerCarClassCompetitionNumberDAO.getRacerCarClassCompetitionNumbersByCompetitionIdAndTeamId(competitionId, teamId);
    }

    @Override
    @Transactional
    public void registrationTeamRacersOnCompetition(Map<String, Object> formMap) {
        String racerCarClassesCompetitionNumbersStr = formMap.get(
                "racerCarClassesCompetitionNumbers").toString();
        Set<RacerCarClassCompetitionNumber> racerCarClassesCompetitionNumbers = getRacerCarClassesCompetitionNumbersFromString(racerCarClassesCompetitionNumbersStr);

        Iterator<RacerCarClassCompetitionNumber> it = racerCarClassesCompetitionNumbers.iterator();
        Racer racer;
        while (it.hasNext()) {
            RacerCarClassCompetitionNumber racerCarClassCompetitionNumber = (RacerCarClassCompetitionNumber) it
                    .next();
            addRacerCarClassCompetitionNumber(racerCarClassCompetitionNumber);
            racer = racerCarClassCompetitionNumber.getRacer();
            LOG.trace("Racer {} {} of team {} had registered on competition in car class {}",
                            racer.getFirstName(), racer.getLastName(), racer.getTeam().getName(),
                            racerCarClassCompetitionNumber.getCarClassCompetition().getCarClass().getName());
        }
    }

    @Override
    @Transactional
    public Set<RacerCarClassCompetitionNumber> getRacerCarClassesCompetitionNumbersFromString(
            String racerCarClassesCompetitionNumbersStr) {
        Set<RacerCarClassCompetitionNumber> racerCarClassesCompetitionNumbers = new HashSet<RacerCarClassCompetitionNumber>();

        String[] racerCarClassesCompetitionNumbersStrParts = racerCarClassesCompetitionNumbersStr
                .split("#");

        for (int i = 0; i < racerCarClassesCompetitionNumbersStrParts.length; i++) {
            String[] racerCarClassCompetitionNumberStrParts = racerCarClassesCompetitionNumbersStrParts[i]
                    .split(",");
            Racer racer = racerService.getRacerById(Integer
                    .parseInt(racerCarClassCompetitionNumberStrParts[0]));
            CarClassCompetition ccc = carClassCompetitionService
                    .getCarClassCompetitionById(Integer
                            .parseInt(racerCarClassCompetitionNumberStrParts[1]));
            RacerCarClassCompetitionNumber rcccn = new RacerCarClassCompetitionNumber(
                    racer, ccc,
                    Integer.parseInt(racerCarClassCompetitionNumberStrParts[2]));
            racerCarClassesCompetitionNumbers.add(rcccn);
        }

        return racerCarClassesCompetitionNumbers;
    }

}
