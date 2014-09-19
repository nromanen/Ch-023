package net.carting.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.Valid;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * The persistent class for the users database table.
 */
@Entity
@Table(name = "users")
public class User implements Serializable, UserDetails {

    private static final long serialVersionUID = 1L;

    public static final String DEFAULT_PASSWORD = "1111";

    // Original props    
    @Id
    @GeneratedValue
    private Integer id;
    
    @Column(name = "username")
    private String username;

    @Column(name = "enabled", nullable = false, columnDefinition = "TINYINT(1)")
    private boolean enabled;

    @Column(name = "password")
    private String password;
    
    @Column(name = "email", nullable = false)
    private String email;
    
    @Column(name = "reset_pass_link")
    private String resetPassLink;

	@ManyToOne(cascade=CascadeType.ALL)
    @JoinColumn(name = "role_id", nullable = false)
	@Valid
    private Role role;

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

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
    
    public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getResetPassLink() {
		return resetPassLink;
	}

	public void setResetPassLink(String resetPassLink) {
		this.resetPassLink = resetPassLink;
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
        this.authorities = listOfAuthorities;
    }

    // Constructors

    public User() {
    }

}
