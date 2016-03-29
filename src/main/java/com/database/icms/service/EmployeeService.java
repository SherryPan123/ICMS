package com.database.icms.service;

import org.hibernate.service.spi.ServiceException;

import com.database.icms.domain.Employee;

public interface EmployeeService {
	
	Employee saveAndGet(Employee employee) throws ServiceException;

	Employee loadByEmployeeId(String employeeId) throws ServiceException;

	Employee loadByName(String name) throws ServiceException;

}
