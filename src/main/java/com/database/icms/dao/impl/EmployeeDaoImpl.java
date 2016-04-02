package com.database.icms.dao.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
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

	@Override
	public List<Employee> listDetail(Integer companyId, String employeeId, String name, int first, int max) {
		Criteria crit = this.getSession().createCriteria(Employee.class);
		if (-1 != companyId) {
			crit.add(Restrictions.eq("company.id", companyId));
		}
		if (null != employeeId)
			crit.add(Restrictions.eq("employeeId", employeeId));
		if (null != name)
			crit.add(Restrictions.eq("name", name));
		crit.setFirstResult(first);
		crit.setMaxResults(max);
		crit.addOrder(Property.forName("id").desc());
		@SuppressWarnings("unchecked")
		List<Employee> employeeList = (List<Employee>)crit.list();
		return employeeList;
	}

	@Override
	public Integer listAllDetailSize(Integer companyId, String employeeId, String name) {
		List<Employee> employeeList = listDetail(companyId, employeeId, name, 0, Integer.MAX_VALUE);
		return employeeList.size();
	}
	
}
