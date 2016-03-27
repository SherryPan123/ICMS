package com.database.icms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.database.icms.bean.CurrentUser;
import com.database.icms.domain.Company;
import com.database.icms.service.CompanyService;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	CompanyService companyService;
	
	@Override
	public UserDetails loadUserByUsername(String name) throws UsernameNotFoundException {
		Company company = companyService.getCompanyByName(name);
        if (company == null) {
            throw new UsernameNotFoundException(String.format("Company with name=%s was not found", name));
        }
        return new CurrentUser(company);
	}

}
