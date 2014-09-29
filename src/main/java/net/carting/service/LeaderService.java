package net.carting.service;

import net.carting.domain.Leader;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public interface LeaderService {
    public List<Leader> getAllLeaders();

    public Leader getLeaderById(int id);

    public void addLeader(Leader leader);

    public void updateLeader(Leader leader);

    public void deleteLeader(Leader leader);

    public Leader getLeaderByUserName(String username);

    public boolean registerLeader(Leader leader) throws NoSuchAlgorithmException, UnsupportedEncodingException;

}
