package net.carting.service;

import net.carting.dao.AdminSettingsDAO;
import net.carting.dao.RacerCarClassCompetitionNumberDAO;
import net.carting.dao.TeamDAO;
import net.carting.dao.TeamInCompetitionDAO;
import net.carting.domain.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

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

    @Override
    @Transactional
    public boolean isValidRacerDocuments(Racer racer, Competition competition) {

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

    @Override
    @Transactional
    public boolean isValidDocumentInCompetition(Document document, Competition competition) {
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
