package net.carting.service;

import static junit.framework.Assert.assertEquals;
import static org.mockito.Mockito.when;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import net.carting.dao.LeaderDAO;
import net.carting.domain.Leader;
import net.carting.domain.Role;
import net.carting.domain.User;
import net.carting.service.LeaderServiceImpl;
import net.carting.service.MailService;
import net.carting.service.RoleService;
import net.carting.service.UserService;
import net.carting.service.Util.TestDatabaseUtil;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
public class LeaderServiceTest {
    @Mock
    private LeaderDAO leaderDAO;

    @InjectMocks
    LeaderServiceImpl leaderService;

    @Mock
    private RoleService roleService;
    
    @Mock
    private UserService userService;

    @Mock
    private MailService mailService;
    
    private TestDatabaseUtil testDatabaseUtil;

    @Before
    public void setUp() throws Exception {
        MockitoAnnotations.initMocks(this);
        
        testDatabaseUtil = new TestDatabaseUtil();
        testDatabaseUtil.dropTestTables();
        testDatabaseUtil.createTestTables();
    }

    @Test
    public void testRegisterLeader() {
        try {
            when(userService.getEncodedPassword("12345")).thenReturn("12345");
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        Role role = new Role();
        role.setRole(UserService.ROLE_TEAM_LEADER);
        when(roleService.getRole(UserService.ROLE_TEAM_LEADER_ID)).thenReturn(role);
        
        Leader newLeader = new Leader();
        newLeader.setFirstName("TestFirstName");
        newLeader.setLastName("TestLastName");
        
        Date bdate = null;
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
        try {
            bdate = formatter.parse("1990-12-12");
        } catch (ParseException e1) {
            e1.printStackTrace();
        }

        newLeader.setBirthday(bdate);
        newLeader.setAddress("My Address 123");
        newLeader.setLicense("TestLicense");
        
        User newUser = new User();
        String username = "jdbc";
        String email = "test@test.com";
        newUser.setEmail(email);
        newUser.setUsername(username);
        newUser.setPassword("12345");
        newLeader.setUser(newUser);

        // Register new leader
        testDatabaseUtil.addLeader(newLeader);
        
        when(userService.getUserByUserName(username)).thenReturn(testDatabaseUtil.getUserByUserName(username));
        when(userService.getUserByEmail(email)).thenReturn(testDatabaseUtil.getUserByEmail(email));

        try {
            // Leader can't be registered with if email or username exists
            assertEquals("Expected " + false, false, leaderService.registerLeader(newLeader));
        } catch (Exception e) {
            e.printStackTrace();
        } 
    }
}