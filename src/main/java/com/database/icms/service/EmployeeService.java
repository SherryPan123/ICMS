package com.database.icms.service;

import org.hibernate.service.spi.ServiceException;

import com.database.icms.domain.Employee;

public interface EmployeeService {
	
	Employee saveAndGet(Employee employee) throws ServiceException;

	Employee loadByEmployeeId(Integer companyId, String employeeId) throws ServiceException;

	Employee loadByName(Integer companyId, String name) throws ServiceException;

}
