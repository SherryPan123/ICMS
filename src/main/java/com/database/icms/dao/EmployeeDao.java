package com.database.icms.dao;


import java.util.List;

import com.database.icms.domain.Employee;

public interface EmployeeDao extends BasicDao<Employee> {

	List<Employee> findByEmployeeId(String employeeId);

	List<Employee> findByName(String name);

	Employee getByCompanyAndEmployeeId(Integer companyId, String employeeId);
    
}
