package net.carting.dao;

import java.util.List;

import net.carting.domain.User;

public interface UserDAO {

    public User getUserByUserName(String userName);
    
    public User getUserByEmail(String email);

    List<String> getAuthoritiesByUserName(String userName);

    public List<User> getAllUsers();

    public void addUser(User user);

    public void updateUser(User user);

    public void deleteUser(User user);

    public boolean isSetUser(String userName);

    public void setEnabled(String username, boolean enabled);

}
