package net.carting.service.Util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import net.carting.domain.Leader;
import net.carting.domain.User;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;

public class TestDatabaseUtil {
    
    private JdbcTemplate jt;
    
    public TestDatabaseUtil() {
        Properties prop = new Properties();
        InputStream inputStream = getClass().getClassLoader().getResourceAsStream("jdbc.properties");
        
        try {
            prop.load(inputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String username = prop.getProperty("jdbc.username");
        String password = prop.getProperty("jdbc.password");
        String url = prop.getProperty("jdbc.databaseurl");
        String driver = prop.getProperty("jdbc.driverClassName");
        
        SingleConnectionDataSource ds = new SingleConnectionDataSource();
        ds.setDriverClassName(driver);
        ds.setUrl(url);
        ds.setUsername(username);
        ds.setPassword(password);

        jt = new JdbcTemplate(ds);
    }
    public boolean dropTestTables() {
        jt.execute("DROP TABLE IF EXISTS `admin_settings`;");
        jt.execute("DROP TABLE IF EXISTS `leaders`;");
        jt.execute("DROP TABLE IF EXISTS `users`;");
        jt.execute("DROP TABLE IF EXISTS `roles`;");
        
        return true;
    }
    public boolean createTestTables() {

        // admin_settings 
        jt.execute("CREATE TABLE `admin_settings` ("+
                    "`id` int(11) NOT NULL AUTO_INCREMENT,"+
                    "`feedback_email` varchar(255) NOT NULL,"+
                    "`parental_permission_years` int(11) NOT NULL,"+
                    "`points_by_places` varchar(255) NOT NULL,"+
                    "PRIMARY KEY (`id`)"+
                    ") ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;");
        jt.execute("INSERT INTO `admin_settings` VALUES (1,'softserve.karting@gmail.com',18,'20,15,12,10,8,6,3,3,1');");
        
                
        // roles table
        jt.execute("CREATE TABLE `roles` ("+
                "`id` int(6) unsigned NOT NULL AUTO_INCREMENT,"+
                "`role` varchar(25) NOT NULL,"+
                "PRIMARY KEY (`id`)"+
                ") ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;");
        jt.execute("INSERT INTO `roles` VALUES (1,'ROLE_ADMIN'),(2,'ROLE_TEAM_LEADER');");
        
        // users table
        jt.execute("CREATE TABLE `users` ("+
                "`id` int(11) unsigned NOT NULL AUTO_INCREMENT,"+
                "`username` varchar(255) NOT NULL,"+
                "`enabled` tinyint(1) NOT NULL,"+
                "`password` varchar(255) DEFAULT NULL,"+
                "`role_id` int(11) unsigned NOT NULL,"+
                "`email` varchar(45) NOT NULL,"+
                "`reset_pass_link` varchar(255) DEFAULT NULL,"+
                "PRIMARY KEY (`id`),"+
                "KEY `FK_users_roles` (`role_id`),"+
                "CONSTRAINT `FK_users_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)"+
                ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;");
        
        // leaders
        jt.execute("CREATE TABLE `leaders` ("+
                "`id` int(11) NOT NULL AUTO_INCREMENT,"+
                "`user_id` int(11) unsigned NOT NULL,"+
                "`address` varchar(255) NOT NULL,"+
                "`birthday` datetime NOT NULL,"+
                "`document` varchar(255) NOT NULL,"+
                "`first_name` varchar(255) NOT NULL,"+
                "`last_name` varchar(255) NOT NULL,"+
                "`license` varchar(255) DEFAULT NULL,"+               
                "`registration_date` datetime DEFAULT NULL,"+
                "PRIMARY KEY (`id`),"+
                "KEY `user_id` (`user_id`),"+
                "CONSTRAINT `leaders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)"+
                ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;");
    
        return true;
    }
    
    public boolean addLeader(Leader leader) {
        
        // Insert user
        jt.execute("INSERT INTO `users` (`username`, `enabled`, `password`, `role_id`, `email`, `reset_pass_link`)"+ 
                                        "VALUES ('"+leader.getUser().getUsername()+"', 0, '"+leader.getUser().getPassword()+"', 2, '"+leader.getUser().getEmail()+"', '123');");
        // get id
         String sql = "SELECT id FROM `users` WHERE `username` ='jdbc'";
         int userId = jt.queryForObject(sql, Integer.class);

        // Insert leader
        jt.execute("INSERT INTO `leaders` (`user_id`, `address`, `birthday`, `document`, `first_name`, `last_name`, `license`, `registration_date`)"+ 
                                "VALUES ("+String.valueOf(userId)+", 'address', '2014-08-28 16:56:19', 'document', 'FirstName', 'LastName', 'license', '2014-08-28 16:56:34');");

        return true;
    }
    
    public User getUserByUserName(String userName) {
        try {
        String sql = "SELECT COUNT(*) FROM `users` WHERE `username` ='"+userName+"'";
        int count = jt.queryForObject(sql, Integer.class);
        if (count != 0) {
            return new User();
        } else {
            return null;
        }

        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
    
    public User getUserByEmail(String email) {
        try {
        String sql = "SELECT COUNT(*) FROM `users` WHERE `email` ='"+email+"'";
        int count = jt.queryForObject(sql, Integer.class);
        if (count != 0) {
            return new User();
        } else {
            return null;
        }
        
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

}