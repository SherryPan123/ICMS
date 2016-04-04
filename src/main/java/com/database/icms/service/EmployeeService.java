package com.database.icms.service;

import java.util.List;

import org.hibernate.service.spi.ServiceException;

import com.database.icms.domain.Employee;

public interface EmployeeService {
	
	Employee saveAndGet(Employee employee) throws ServiceException;

	Employee loadByEmployeeId(Integer companyId, String employeeId) throws ServiceException;

	Employee loadByName(Integer companyId, String name) throws ServiceException;

	List<Employee> listDetail(Integer companyId, String employeeId, String name, int first, int max);

	Integer listAllDetailSize(Integer companyId, String employeeId, String name);

	Employee load(Integer id);

	void update(Employee employee);

	void save(Employee employee);

}
