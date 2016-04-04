package com.database.icms.dao;


import java.util.List;

import com.database.icms.domain.Employee;

public interface EmployeeDao extends BasicDao<Employee> {

	List<Employee> findByEmployeeId(Integer companyId, String employeeId);

	List<Employee> findByName(Integer companyId, String name);

	List<Employee> listDetail(Integer companyId, String employeeId, String name, int first, int max);

	Integer listAllDetailSize(Integer companyId, String employeeId, String name);

	Integer[] findEmployeeIdByEmployeeInfo(String employeeInfo);
    
}
