package com.database.icms.service;

import org.hibernate.service.spi.ServiceException;

import com.database.icms.domain.Role;

public interface RoleService {

	Role getRoleByName(String name) throws ServiceException;

	void save(Role role);
	
}
