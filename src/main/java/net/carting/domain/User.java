package net.carting.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.persistence.*;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * The persistent class for the users database table.
 * 
 */
@Entity
@Table(name = "users")
public class User implements Serializable, UserDetails {

	private static final long serialVersionUID = 1L;

	public static final String DEFAULT_PASSWORD = "1111";

	// Original props

	@Id
	@Column(name = "username")
	private String username;

	@Column(name = "enabled", nullable = false, columnDefinition = "TINYINT(1)")
	private boolean enabled;

	@Column(name = "password")
	private String password;

	// bi-directional one-to-one association to Authority
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "username", nullable = false)
	private Authority authority;

	// Getters & Setters for original props

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public Authority getAuthority() {
		return this.authority;
	}

	public void setAuthority(Authority authority) {
		this.authority = authority;
	}

	// Spring Security props

	private transient Collection<GrantedAuthority> authorities;

	// UserDetails methods

	@Transient
	public Collection<GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Transient
	public boolean isAccountNonExpired() {
		return true;
	}

	@Transient
	public boolean isAccountNonLocked() {
		return true;
	}

	@Transient
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Transient
	public boolean isEnabled() {
		return enabled;
	}

	@Transient
	public void setUserAuthorities(List<String> authorities) {
		List<GrantedAuthority> listOfAuthorities = new ArrayList<GrantedAuthority>();
		for (String role : authorities) {
			listOfAuthorities.add(new SimpleGrantedAuthority(role));
		}
		this.authorities = (Collection<GrantedAuthority>) listOfAuthorities;
	}

	// Constructors

	public User() {
	}

}
