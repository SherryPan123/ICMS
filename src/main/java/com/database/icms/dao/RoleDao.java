package com.database.icms.dao;

import com.database.icms.domain.Role;

public interface RoleDao extends BasicDao<Role> {

	Role findByName(String name);

}
