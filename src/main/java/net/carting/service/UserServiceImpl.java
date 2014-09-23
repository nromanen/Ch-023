package net.carting.service;

import net.carting.dao.UserDAO;
import net.carting.domain.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Iterator;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private static final Logger LOG = LoggerFactory.getLogger(UserServiceImpl.class);

    @Autowired
    private UserDAO userDao;

    @Autowired
    private AdminSettingsService adminSettingsService;

    @Autowired
    private MailService mailService;

    @Override
    @Transactional
    public User getUserByUserName(String userName) {
        return userDao.getUserByUserName(userName);
    }

    @Override
    @Transactional
    public User getUserByEmail(String email) {
        return userDao.getUserByEmail(email);
    }

    @Override
    @Transactional
    public List<String> getAuthoritiesByUserName(String userName) {
        return userDao.getAuthoritiesByUserName(userName);
    }

    public UserDAO getUserDao() {
        return userDao;
    }

    public void setUserDao(UserDAO userDao) {
        this.userDao = userDao;
    }

    @Override
    @Transactional
    public List<User> getAllUsers() {
        return userDao.getAllUsers();
    }

    @Override
    @Transactional
    public void addUser(User user) {
        userDao.addUser(user);

    }

    @Override
    @Transactional
    public void updateUser(User user) {
        userDao.updateUser(user);

    }

    @Override
    @Transactional
    public void deleteUser(User user) {
        userDao.deleteUser(user);

    }

    @Override
    @Transactional
    public String getCurrentUserName() {
        Authentication auth = SecurityContextHolder.getContext()
                .getAuthentication();
        return auth.getName();
    }


    @SuppressWarnings("unchecked")
    @Override
    @Transactional
    public String getCurrentAuthority() {
        LOG.debug("Start getCurrentAuthority method");
        Authentication auth = SecurityContextHolder.getContext()
                .getAuthentication();
        String authority = null;
        Iterator<GrantedAuthority> iterator = (Iterator<GrantedAuthority>) auth.getAuthorities().iterator();
        while (iterator.hasNext()) {
            authority = iterator.next().toString();
        }
        LOG.debug("End getCurrentAuthority method");
        return authority;
    }

    @Override
    @Transactional
    public boolean isSetUser(String userName) {
        return userDao.isSetUser(userName);
    }

    @Override
    @Transactional
    public boolean isSetEmail(String email) {
        return userDao.isSetEmail(email);
    }

    @Override
    public String getEncodedPassword(String password)
            throws NoSuchAlgorithmException, UnsupportedEncodingException {
        LOG.debug("Start getEncodedPassword method");
        MessageDigest md;
        md = MessageDigest.getInstance("SHA-256");
        md.update(password.getBytes("UTF-8"));
        byte byteData[] = md.digest();
        StringBuffer hexPassword = new StringBuffer();
        for (int i = 0; i < byteData.length; i++) {
            String hex = Integer.toHexString(0xff & byteData[i]);
            if (hex.length() == 1) {
                hexPassword.append('0');
            }  
            hexPassword.append(hex);
        }
        LOG.debug("End getEncodedPassword method");
        return hexPassword.toString();
    }

    @Override
    @Transactional
    public void setEnabled(String username, boolean enabled) {
        userDao.setEnabled(username, enabled);
    }

    @Override
    @Transactional
    public void resetPassword(User user)
            throws NoSuchAlgorithmException, UnsupportedEncodingException {
        user.setPassword(getEncodedPassword(User.DEFAULT_PASSWORD));
        userDao.updateUser(user);
    }

    @Override
    @Transactional
    public void changePassword(User user, String password)
            throws NoSuchAlgorithmException, UnsupportedEncodingException {
        user.setPassword(getEncodedPassword(password));
        userDao.updateUser(user);
    }

    @Override
    @Transactional
    public void sendSecureCode(User user) {
        LOG.debug("Start senSecureCode method");
        try {
            String secureCode = getEncodedPassword(user.getUsername() + user.getPassword());
            user.setResetPassLink(secureCode);
            userDao.updateUser(user);

            String to = user.getEmail();
            String from = adminSettingsService.getAdminSettings().getFeedbackEmail();
            String subject = "Password recovery on Carting";
            mailService.sendMail(to, from, subject, secureCode);
            LOG.debug("Sent secure code to user(username = {})", user.getUsername());

        } catch (NoSuchAlgorithmException e) {
            LOG.debug("Error has occured in sendSecureCode method", e);
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            LOG.debug("Error has occured in sendSecureCode method", e);
            e.printStackTrace();
        }
    }

}