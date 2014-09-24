package net.carting.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.carting.dao.AdminSettingsDAO;
import net.carting.dao.RacerCarClassCompetitionNumberDAO;
import net.carting.dao.TeamDAO;
import net.carting.dao.TeamInCompetitionDAO;
import net.carting.domain.Competition;
import net.carting.domain.Document;
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
public class TeamInCompetitionServiceImpl implements TeamInCompetitionService {

	private static final Logger LOG = LoggerFactory.getLogger(TeamInCompetitionServiceImpl.class);
	
    @Autowired
    private TeamInCompetitionDAO teamInCompetitionDAO;
    @Autowired
    private RacerCarClassCompetitionNumberDAO racerCarClassCompetitionNumberDAO;
    @Autowired
    private AdminSettingsDAO adminSettingsDAO;
    @Autowired
    private TeamDAO teamDAO;
    
    @Override
    @Transactional
    public boolean isTeamInCompetition(int teamId, int competitonId) {
        return teamInCompetitionDAO.isTeamInCompetition(teamId, competitonId);
    }

    @Override
    @Transactional
    public void addTeamInCompetition(TeamInCompetition teamInCompetition) {
        teamInCompetitionDAO.addTeamInCompetition(teamInCompetition);
    }

    @Override
    @Transactional
    public void deleteTeamInCompetition(TeamInCompetition teamInCompetition) {
        teamInCompetitionDAO.deleteTeamInCompetition(teamInCompetition);
    }

    @Override
    @Transactional
    public List<TeamInCompetition> getTeamInCompetitionListByTeamId(int teamId) {
        return teamInCompetitionDAO.getTeamInCompetitionListByTeamId(teamId);
    }
    
    @Override
    @Transactional
    public List<TeamInCompetition> getTeamInCompetitionListByTeamIdForCurrentYear(int teamId) {
        return teamInCompetitionDAO.getTeamInCompetitionListByTeamIdForCurrentYear(teamId);
    }

    @Override
    @Transactional
    public void deleteTeamInCompetitionByTeamIdAndCompetitionId(int teamId, int competitionId) {
        teamInCompetitionDAO.deleteTeamInCompetitionByTeamIdAndCompetitionId(teamId, competitionId);
    }

    @Override
    @Transactional
    public Map<TeamInCompetition, Boolean> isValidTeamInCompetitionMap(List<TeamInCompetition> teamInCompetitionList) {
    	LOG.debug("Start isValidTeamInCompetitionMap method");
        Map<TeamInCompetition, Boolean> result = new LinkedHashMap<TeamInCompetition, Boolean>();

        for (TeamInCompetition teamInCompetition : teamInCompetitionList) {

            List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumbers =
                    racerCarClassCompetitionNumberDAO.getRacerCarClassCompetitionNumbersByCompetitionIdAndTeamId(
                            teamInCompetition.getCompetition().getId(), teamInCompetition.getTeam().getId());

            boolean isValid = true;
            for (RacerCarClassCompetitionNumber racerCarClassCompetitionNumber : racerCarClassCompetitionNumbers) {
                Racer racer = racerCarClassCompetitionNumber.getRacer();
                Competition competition = racerCarClassCompetitionNumber.getCarClassCompetition().getCompetition();
                if (!isValidRacerDocuments(racer, competition)) {
                    isValid = false;
                    break;
                }
            }
            result.put(teamInCompetition, isValid);
        }
        LOG.debug("End isValidTeamInCompetitionMap method");
        return result;
    }

    /**
     * This method gets is valid racers documents
     *
     * @param racer       - racer in which we want to check documents
     * @param competition - competition in which we want to check racers documents
     * @return <code>true</code> if all racers documents is valid,
     * and <code>false</code> if one of documents is not valid
     * @author Ivan Kozub
     */
    private boolean isValidRacerDocuments(Racer racer, Competition competition) {

        int perentalPermissionsYears = adminSettingsDAO.getAdminSettings().getParentalPermissionYears();

        if (!isValidDocumentInCompetition(racer.getDocumentByType(Document.TYPE_RACER_LICENCE), competition)) {
            return false;
        }
        if (!isValidDocumentInCompetition(racer.getDocumentByType(Document.TYPE_RACER_INSURANCE), competition)) {
            return false;
        }
        if (!isValidDocumentInCompetition(racer.getDocumentByType(Document.TYPE_RACER_MEDICAL_CERTIFICATE), competition)) {
            return false;
        }
        if (racer.getAge() < perentalPermissionsYears) {
            if (!isValidDocumentInCompetition(racer.getDocumentByType(Document.TYPE_RACER_PARENTAL_PERMISSIONS), competition)) {
                return false;
            }
        }
        return true;
    }

    /**
     * This method gets is valid document in competition
     *
     * @param document    - document which we want to check
     * @param competition - competition in which we want to check document
     * @return <code>true</code> if document is valid in competition,
     * and <code>false</code> if document is not valid
     * @author Ivan Kozub
     */
    private boolean isValidDocumentInCompetition(Document document, Competition competition) {
        if (document == null) {
            return false;
        } else {
            if (!document.isApproved()) {
                return false;
            } else {
                Date finishDate = document.getFinishDate();
                if (!(finishDate == null) && finishDate.before(competition.getDateEnd())) {
                    return false;
                }
            }
        }
        return true;
    }
    
    @Override
    @Transactional
    public List<Team> getTeamsByCompetitionId(int id) {
        List<Team>teams = teamDAO.getAllTeams();
        List<Team>resultList = new ArrayList<Team>();
        for (Team team:teams) {
            if(teamInCompetitionDAO.isTeamInCompetition(team.getId(), id)) {
                resultList.add(team);
            }
        }
        if (!resultList.isEmpty()) {
            return resultList;
        } else {
            return null;
        }
    }

}
