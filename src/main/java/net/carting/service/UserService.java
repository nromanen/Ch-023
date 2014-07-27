package net.carting.service;

import net.carting.domain.User;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public interface UserService {

    public static final String ROLE_TEAM_LEADER = "ROLE_TEAM_LEADER";

    public static final String ROLE_ANONYMOUS = "ROLE_ANONYMOUS";

    public static final String ROLE_ADMIN = "ROLE_ADMIN";

    public User getUserByUserName(String userName);

    public List<String> getAuthoritiesByUserName(String userName);

    public List<User> getAllUsers();

    public void addUser(User user);

    public void updateUser(User user);

    public void deleteUser(User user);

    public String getCurrentUserName();

    public String getCurrentAuthority();

    public boolean isSetUser(String user_name);

    public String getEncodedPassword(String password)
            throws NoSuchAlgorithmException, UnsupportedEncodingException;

    public void setEnabled(String username, boolean enabled);

    public void resetPassword(User user)
            throws NoSuchAlgorithmException, UnsupportedEncodingException;

    public void changePassword(User user, String password)
            throws NoSuchAlgorithmException, UnsupportedEncodingException;

}
