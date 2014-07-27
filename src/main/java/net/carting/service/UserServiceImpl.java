package net.carting.service;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.carting.dao.UserDAO;
import net.carting.domain.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDao;

	@Override
	@Transactional
	public User getUserByUserName(String userName) {
		return userDao.getUserByUserName(userName);
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
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String authority = null;
		Iterator<GrantedAuthority> iterator = (Iterator<GrantedAuthority>) auth.getAuthorities().iterator();
		while (iterator.hasNext()) {
			authority = (String) iterator.next().toString();
		}
		return authority;
	}

	@Override
	@Transactional
	public boolean isSetUser(String user_name) {
		return userDao.isSetUser(user_name);
	}

	@Override
	public String getEncodedPassword(String password)
			throws NoSuchAlgorithmException, UnsupportedEncodingException {
		MessageDigest md;
		md = MessageDigest.getInstance("SHA-256");
		md.update(password.getBytes("UTF-8"));
		byte byteData[] = md.digest();
		StringBuffer hexPassword = new StringBuffer();
		for (int i = 0; i < byteData.length; i++) {
			String hex = Integer.toHexString(0xff & byteData[i]);
			if (hex.length() == 1)
				hexPassword.append('0');
			hexPassword.append(hex);
		}
		return hexPassword.toString();
	}

	@Override
	@Transactional
	public void setEnabled(String username, boolean enabled){
		userDao.setEnabled(username, enabled);
	}

	@Override
	@Transactional
	public void resetPassword(User user)
			throws NoSuchAlgorithmException, UnsupportedEncodingException {
		User userToUpdate = user;
		userToUpdate.setPassword(getEncodedPassword(User.DEFAULT_PASSWORD));
		userDao.updateUser(userToUpdate);
	}

	@Override
	@Transactional
	public void changePassword(User user, String password) 
			throws NoSuchAlgorithmException, UnsupportedEncodingException {
		User userToUpdate = user;
		userToUpdate.setPassword(getEncodedPassword(password));
		userDao.updateUser(userToUpdate);
	}

}