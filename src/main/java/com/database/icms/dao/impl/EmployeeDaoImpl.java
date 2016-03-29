package com.database.icms.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.database.icms.dao.EmployeeDao;
import com.database.icms.domain.Employee;

@Repository("EmployeeDao")
public class EmployeeDaoImpl extends BasicDaoImpl<Employee> implements EmployeeDao {

	@Override
	public List<Employee> findByEmployeeId(String employeeId) {
		String hql = "from Employee e where e.id like ? order by e.id asc";
		employeeId = "%" + employeeId + "%";
		return this.findByHql(hql, new Object[] { employeeId });
	}

	@Override
	public List<Employee> findByName(String name) {
		String hql = "from Employee e where e.name like ? order by e.id asc";
		name = "%" + name + "%";
		return this.findByHql(hql, new Object[] { name });
	}

	@Override
	public Employee getByCompanyAndEmployeeId(Integer companyId, String employeeId) {
		String hql = "from Employee e where e.company.id = ? and e.employeeId = ?";
		Object[] params = new Object[] { companyId, employeeId };
		List<Employee> employeeList = this.findByHql(hql, params);
		if (null == employeeList || 1 != employeeList.size())
			return null;
		else
			return employeeList.get(0);
	}
	
}
