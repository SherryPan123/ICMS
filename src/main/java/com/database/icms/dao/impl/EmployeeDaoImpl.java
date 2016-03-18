package com.database.icms.dao.impl;

import org.springframework.stereotype.Repository;

import com.database.icms.dao.EmployeeDao;
import com.database.icms.domain.Employee;

@Repository("EmployeeDao")
public class EmployeeDaoImpl extends BasicDaoImpl<Employee> implements EmployeeDao {
	
}
