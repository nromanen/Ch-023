package net.carting.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import net.carting.dao.CompetitionDAO;
import net.carting.domain.CarClass;
import net.carting.domain.CarClassCompetition;
import net.carting.domain.Competition;
import net.carting.domain.RacerCarClassCompetitionNumber;
import net.carting.domain.Team;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CompetitionServiceImpl implements CompetitionService {

    @Autowired
    private CompetitionDAO competitionDAO;

    @Override
    @Transactional
    public List<Competition> getAllCompetitions() {
        return competitionDAO.getAllCompetitions();
    }

    @Override
    @Transactional
    public List<Competition> getAllEnabledCompetitions() {
        return competitionDAO.getAllEnabledCompetitions();
    }

    @Override
    @Transactional
    public List<Competition> getCompetitionsByYear(int year) {
        return competitionDAO.getCompetitionsByYear(year);
    }

    @Override
    @Transactional
    public List<Competition> getAllCompetitionsByPage(int page) {
        return competitionDAO.getAllCompetitionsByPage(page);
    }

    @Override
    @Transactional
    public Competition getCompetitionById(int id) {
        return competitionDAO.getCompetitionById(id);
    }

    @Override
    @Transactional
    public void addCompetition(Competition competition) {
        competitionDAO.addCompetition(competition);
    }

    @Override
    @Transactional
    public void updateCompetition(Competition competition) {
        competitionDAO.updateCompetition(competition);
    }

    @Override
    @Transactional
    public void deleteCompetition(Competition competition) {
        competitionDAO.deleteCompetition(competition);
    }

    @Override
    @Transactional
    public void setEnabled(int competitionId, boolean enabled) {
        competitionDAO.setEnabled(competitionId, enabled);
    }

    @Override
    @Transactional
    public List<Integer> getCompetitionsYearsList() {
        return competitionDAO.getCompetitionsYearsList();
    }

    @Override
    public List<CarClass>
    getDifferenceBetweenCarClassesAndCarClassCompetitions(List<CarClass> carClasses,
                                                          List<CarClassCompetition> carClassCompetitions) {

        List<CarClass> carClassesResult = new ArrayList<CarClass>();
        for (int i = 0; i < carClasses.size(); i++) {
            boolean notExists = true;
            CarClass tempCarClass = carClasses.get(i);
            for (int j = 0; j < carClassCompetitions.size(); j++) {
                if (tempCarClass.equals(carClassCompetitions.get(j).getCarClass())) {
                    notExists = false;
                    break;
                }
            }
            if (notExists) {
                carClassesResult.add(tempCarClass);
            }
        }
        return carClassesResult;
    }

    @Override
    public List<Team> getTeamsFromRacerCarClassCompetitionNumbers(
            List<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumbers) {

        List<Team> teams = new ArrayList<Team>();
        for (int i = 0; i < racerCarClassCompetitionNumbers.size(); i++) {
            Team team = racerCarClassCompetitionNumbers.get(i).getRacer().getTeam();
            if (!teams.contains(team)) {
                teams.add(team);
            }
        }
        return teams;
    }
    
    @Override
    public List<String> getPointsByPlacesList(Competition competition) {
        String pointsByPlacesStr = competition.getPointsByPlaces();
        List<String> pointsByPlacesList = Arrays.asList(pointsByPlacesStr.split(","));
        return pointsByPlacesList;
    }
    


}
