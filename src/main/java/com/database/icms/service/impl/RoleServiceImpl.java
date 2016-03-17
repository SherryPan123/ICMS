package com.database.icms.service.impl;

import javax.transaction.Transactional;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.database.icms.dao.RoleDao;
import com.database.icms.domain.Role;
import com.database.icms.service.RoleService;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {
	
	@Autowired
	private RoleDao roleDao;

	@Override
	public Role getRoleByName(String name) throws ServiceException {
		try {
			return roleDao.findByName(name);
		} catch(DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
		
	}

	@Override
	public void save(Role role) throws ServiceException {
		try {
			roleDao.save(role);
		} catch(DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

}
