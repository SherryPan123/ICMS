package com.database.icms.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.database.icms.dao.EmployeeDao;
import com.database.icms.domain.Employee;

@Repository("EmployeeDao")
public class EmployeeDaoImpl extends BasicDaoImpl<Employee> implements EmployeeDao {

	@Override
	public List<Employee> findByEmployeeId(Integer companyId, String employeeId) {
		String hql = "from Employee e where e.company.id = ? and e.employeeId = ? order by e.id asc";
		return this.findByHql(hql, new Object[] { companyId, employeeId });
	}

	@Override
	public List<Employee> findByName(Integer companyId, String name) {
		String hql = "from Employee e where e.company.id = ? and e.name = ? order by e.id asc";
		return this.findByHql(hql, new Object[] { companyId, name });
	}
	
}
