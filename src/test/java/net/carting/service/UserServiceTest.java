package net.carting.service;

import net.carting.dao.UserDAO;
import net.carting.domain.User;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.runners.MockitoJUnitRunner;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import static junit.framework.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class UserServiceTest {

	@InjectMocks
	UserServiceImpl userService;

	@Mock
	private UserDAO userDAO;

	@Before
	public void init() {
		MockitoAnnotations.initMocks(this);
	}

	@Test
	public void testGetUserByUserName() throws Exception {
		User user = new User();
		user.setUsername("user");
		when(userDAO.getUserByUserName("user")).thenReturn(user);
		user = userService.getUserByUserName("user");
		assertNotNull("User was not found", user);
		assertEquals("Expected 'user'", "user", user.getUsername());
	}

	@Test
	public void testGetAuthoritiesByUserName() throws Exception {
		List<String> authorities = new ArrayList<String>();
		authorities.add("ROLE_USER");
		authorities.add("ROLE_ADMIN");
		when(userDAO.getAuthoritiesByUserName("admin")).thenReturn(authorities);
		assertEquals("Expected 2 authorities to admin", 2,
				(userService.getAuthoritiesByUserName("admin").size()));
	}

	@Test
	public void testGetAllUsers() {
		List<User> userList = new ArrayList<User>();
		userList.add(new User());
		userList.add(new User());
		when(userDAO.getAllUsers()).thenReturn(userList);
		assertEquals("Expected 2 users", 2, userService.getAllUsers().size());
	}

	@Test
	public void testAddUser() {
		User user = new User();
		user.setUsername("user");
		userService.addUser(user);
		verify(userDAO, times(1)).addUser(user);
	}

	@Test
	public void testUpdateUser() {
		User user = new User();
		user.setUsername("user");
		userService.updateUser(user);
		verify(userDAO, times(1)).updateUser(user);
	}

	@Test
	public void testDeleteUser() {
		User user = new User();
		user.setUsername("user");
		userService.deleteUser(user);
		verify(userDAO, times(1)).deleteUser(user);
	}

	@Test
	public void testGetEncodedPassword() throws NoSuchAlgorithmException,
			UnsupportedEncodingException {
		String password = "1234";
		assertEquals(
				"Expected '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4'",
				"03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4",
				userService.getEncodedPassword(password));
	}
}
