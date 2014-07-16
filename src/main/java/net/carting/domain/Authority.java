package net.carting.domain;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The persistent class for the authorities database table.
 * 
 */
@Entity
@Table(name = "authorities")
public class Authority implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "username")
	private String username;

	@Column(name = "authority")
	private String authority; // Spring Security demands them to start with
								// "ROLE_"

	public Authority() {
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getAuthority() {
		return this.authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

}