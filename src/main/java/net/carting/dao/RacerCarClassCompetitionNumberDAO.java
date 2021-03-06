package net.carting.dao;

import java.util.List;

import net.carting.domain.RacerCarClassCompetitionNumber;

public interface RacerCarClassCompetitionNumberDAO {

    public List<RacerCarClassCompetitionNumber> getAllRacerCarClassCompetitionNumbers();

    public RacerCarClassCompetitionNumber getRacerCarClassCompetitionNumberById(int id);

    public void addRacerCarClassCompetitionNumber(RacerCarClassCompetitionNumber racerCarClassCompetitionNumber);

    public void updateRacerCarClassCompetitionNumber(RacerCarClassCompetitionNumber racerCarClassCompetitionNumber);

    public void deleteRacerCarClassCompetitionNumber(RacerCarClassCompetitionNumber racerCarClassCompetitionNumber);

    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCarClassCompetitionId(int id);

    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCarClassCompetitionIdAndTeamId(int carClassCompetitionid, int teamId);

    public int getRacerCarClassCompetitionNumbersCountByCarClassCompetitionId(int id);

    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCompetitionId(int id);

    public void deleteByCarClassCompetitionIdAndRacerId(int carClassCompetitonId, int racerId);

    public List<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbersByCompetitionIdAndTeamId(int competitionId, int teamId);

}
