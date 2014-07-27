package net.carting.dao;

import net.carting.domain.Leader;

import java.util.List;

public interface LeaderDAO {

    public List<Leader> getAllLeaders();

    public Leader getLeaderById(int id);

    public void addLeader(Leader leader);

    public void updateLeader(Leader leader);

    public void deleteLeader(Leader leader);

    public Leader getLeaderByUserName(String username);

}
