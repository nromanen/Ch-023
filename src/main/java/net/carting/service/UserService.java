package net.carting.service;

import net.carting.domain.User;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public interface UserService {

    public static final int ROLE_ADMIN_ID = 1;
    public static final String ROLE_ADMIN = "ROLE_ADMIN";

	public static final String ROLE_TEAM_LEADER = "ROLE_TEAM_LEADER";
    public static final int ROLE_TEAM_LEADER_ID = 2;

    public static final String ROLE_ANONYMOUS = "ROLE_ANONYMOUS";
    public static final int ROLE_ANONYMOUS_ID = 3;

    public User getUserByUserName(String userName);
    
    public User getUserByEmail(String email);

    public List<String> getAuthoritiesByUserName(String userName);

    public List<User> getAllUsers();

    public void addUser(User user);

    public void updateUser(User user);

    public void deleteUser(User user);

    public String getCurrentUserName();
    
    public String getCurrentAuthority();

    public boolean isSetUser(String userName);
    
    public boolean isSetEmail(String email);

    public String getEncodedPassword(String password)
            throws NoSuchAlgorithmException, UnsupportedEncodingException;

    public void setEnabled(String userName, boolean enabled);

    public void resetPassword(User user)
            throws NoSuchAlgorithmException, UnsupportedEncodingException;

    public void changePassword(User user, String password)
            throws NoSuchAlgorithmException, UnsupportedEncodingException;
    
    /** 
     * This method send secure code to user during password recovery.
     * <p/>
     * Secure code is formed by username and password of this user.
     * @param user - user, that want to get secure code
     * @author Mykola Galchuk
     *
     *
     */
    public void sendSecureCode(User user);

}
