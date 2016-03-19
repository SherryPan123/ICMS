package com.database.icms.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.database.icms.dao.RoleDao;
import com.database.icms.domain.Role;

@Repository
public class RoleDaoImpl extends BasicDaoImpl<Role> implements RoleDao {

	@Override
	public Role findByName(String name) {
		String hql = "from Role r where r.name = ?";
		Object[] params = new Object[] { name };
		List<Role> roleList = this.findByHql(hql, params);
		if (!roleList.isEmpty()) return roleList.get(0);
		else return null;
	}

}
