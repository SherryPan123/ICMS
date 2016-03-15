package com.database.icms.bean;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.database.icms.domain.Company;

public class CurrentUser extends Company implements UserDetails {

	public CurrentUser(Company company) {
        if (company != null) {
            this.setId(company.getId());
            this.setName(company.getName());
            this.setPassword(company.getPassword());
            this.setAddress(company.getAddress());
            this.setPhone(company.getPhone());
        }
    }
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return null;
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
