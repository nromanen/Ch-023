package net.carting.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import net.carting.domain.RacerCarClassCompetitionNumber;

public interface RacerCarClassCompetitionNumberService {

    /**
     * This method return all registered racers(with their numbers) on all classes in all competitions
     *
     * @author Ivan Kozub
     */
    public List<RacerCarClassCompetitionNumber> getAllRacerCarClassCompetitionNumbers();

    /**
     * This method register racer on car class in competition with preset number.
     * If this racer is first registered racer in this competition from his team
     * then register his team on competition
     *
     * @author Ivan Kozub
     */
    public void addRacerCarClassCompetitionNumber(RacerCarClassCompetitionNumber racerCarClassCompetitionNumber);

    /**
     * This method gets list of registered racers(with their numbers) on specific car class of competition
     *
     * @param id - id of car class of competition
     * @return list of registered racers(with their numbers) on specific car class of competition
     * @author Ivan Kozub
     */
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCarClassCompetitionId(int id);

    /**
     * This method gets list of registered racers(with their numbers) by team on specific car class of competition
     *
     * @param carClassCompetitionid - id of car class of competition
     * @param teamId                - id of team
     * @return list of registered racers(with their numbers) by team on specific car class of competition
     * @author Ivan Kozub
     */
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCarClassCompetitionIdAndTeamId(int carClassCompetitionid, int teamId);

    /**
     * This method gets count of registered racers on car class of competition
     *
     * @param id - id of car class of competition
     * @return count of registered racers on car class of competition
     * @author Ivan Kozub
     */
    public int getRacerCarClassCompetitionNumbersCountByCarClassCompetitionId(int id);

    /**
     * This method gets list of registered racers(with their numbers) on specific competition
     *
     * @param id - id of competition
     * @return list of registered racers(with their numbers) on specific competition
     * @author Ivan Kozub
     */
    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCompetitionId(int id);

    /**
     * This method unregister racer from specific car class of competition.
     *
     * @param carClassCompetitonId - id of car class of competition
     * @param racerId              - id of racer
     * @author Ivan Kozub
     */
    public void deleteByCarClassCompetitionIdAndRacerId(int carClassCompetitonId, int racerId);

    /**
     * This method gets list of registered racers(with their numbers) by team on specific competition
     *
     * @param competitionId - id of competition
     * @param teamId        - id of team
     * @return list of registered racers(with their numbers) by team on specific competition
     * @author Ivan Kozub
     */
    public List<RacerCarClassCompetitionNumber>
    getRacerCarClassCompetitionNumbersByCompetitionIdAndTeamId(int competitionId, int teamId);

    /**
     * <p/>
     * Implementation of this method added racerCarClassCompetitionNumbers
     * (instances of
     * {@link net.carting.domain.RacerCarClassCompetitionNumber}) to database
     * (registers the racers for the competition)
     *
     * @param formMap - map with data from form which contains car numbers of racer
     *                in car classes for a competition in one string
     * @author Volodymyr Semaniv
     */
    public void registrationTeamRacersOnCompetition(Map<String, Object> formMap);

    /**
     * <p/>
     * Implementation of this method parses racerCarClassCompetitionNumbers
     * (instance of
     * {@link net.carting.domain.RacerCarClassCompetitionNumber}) from string
     * representation
     *
     * @param racerCarClassesCompetitionNumbersStr racerCarClassCompetitionNumbers from string representation
     *                                             (instance of
     *                                             {@link net.carting.domain.RacerCarClassCompetitionNumber}) -
     *                                             string representation of
     * @return set of racerCarClassCompetitionNumbers
     * (instance of
     * {@link net.carting.domain.RacerCarClassCompetitionNumber})
     * @author Volodymyr Semaniv
     */
    public Set<RacerCarClassCompetitionNumber> getRacerCarClassesCompetitionNumbersFromString(
            String racerCarClassesCompetitionNumbersStr);

}
