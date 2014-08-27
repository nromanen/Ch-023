package net.carting.dao;

import java.util.List;

import net.carting.domain.Leader;

public interface LeaderDAO {

    public List<Leader> getAllLeaders();

    public Leader getLeaderById(int id);

    public void addLeader(Leader leader);

    public void updateLeader(Leader leader);

    public void deleteLeader(Leader leader);

    public Leader getLeaderByUserName(String username);
    //public Leader getLeaderByUserId(int userId);

}
