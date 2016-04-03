package com.database.icms.bean;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.database.icms.domain.Company;
import com.database.icms.domain.Role;

public class CurrentUser extends Company implements UserDetails {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public CurrentUser(Company company) {
        if (company != null) {
            this.setId(company.getId());
            this.setName(company.getName());
            this.setUsername(company.getUsername());
            this.setPassword(company.getPassword());
            this.setAddress(company.getAddress());
            this.setPhone(company.getPhone());
            this.setCars(company.getCars());
            this.setEmployees(company.getEmployees());
            this.setRole(company.getRole());
        }
    }
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> authorities = new ArrayList<>();
		Role role = this.getRole();
		if (role != null) {
			SimpleGrantedAuthority authority = new SimpleGrantedAuthority(role.getName());
			System.out.println("角色为"+role.getName());
            authorities.add(authority);
		}
		return authorities;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

	@Override
	public String getUsername() {
		return this.getName();
	}
	
}