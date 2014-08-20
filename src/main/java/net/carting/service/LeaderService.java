package net.carting.service;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import net.carting.domain.Leader;

public interface LeaderService {
    public List<Leader> getAllLeaders();

    public Leader getLeaderById(int id);

    public void addLeader(Leader leader);

    public void updateLeader(Leader leader);

    public void deleteLeader(Leader leader);

    public Leader getLeaderByUserName(String username);

    /**
     * <p/>
     * Implementation of this method registers a leader in a system, namely adds
     * leader (instances of {@link net.carting.domain.Leader}),
     * user (instances of {@link net.carting.domain.User}),
     * authority (instances of {@link net.carting.domain.Authority})
     * to database and and connects them.
     *
     * @param formMap - map with data from form which contains such information:
     *                <ul>
     *                <li>firstName</li>
     *                <li>lastName</li>
     *                <li>birthday</li>
     *                <li>document (identefication)</li>
     *                <li>license (license number) </li>
     *                <li>address</li>
     *                <li>username</li>
     *                <li>password</li>
     *                </ul>
     * @author Volodymyr Semaniv
     */
    public void registerLeader(Leader leader) throws NoSuchAlgorithmException, UnsupportedEncodingException;

}
