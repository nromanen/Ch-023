package net.carting.dao;

import net.carting.domain.User;

import java.util.List;

public interface UserDAO {

    public User getUserByUserName(String userName);
    
    public User getUserByEmail(String email);

    List<String> getAuthoritiesByUserName(String userName);

    public List<User> getAllUsers();

    public void addUser(User user);

    public void updateUser(User user);

    public void deleteUser(User user);

    public boolean isSetUser(String userName);
    
    public boolean isSetEmail(String email);

    public void setEnabled(String username, boolean enabled);

}
