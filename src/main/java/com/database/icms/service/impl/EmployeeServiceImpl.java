package com.database.icms.service.impl;

import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.database.icms.dao.EmployeeDao;
import com.database.icms.domain.Company;
import com.database.icms.domain.Employee;
import com.database.icms.service.CompanyService;
import com.database.icms.service.EmployeeService;

@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	EmployeeDao employeeDao;

	@Autowired
	CompanyService companyService;

	@Override
	public Employee loadByEmployeeId(String employeeId) throws ServiceException {
		try {
			List<Employee> employeeList = employeeDao.findByEmployeeId(employeeId);
			if (employeeList.isEmpty() && employeeList.size() == 1) {
				return employeeList.get(0);
			}
			return null;
        } catch (DataAccessException e) {
            throw new ServiceException(e.getMessage(), e.getCause());
        }
	}

	@Override
	public Employee loadByName(String name) throws ServiceException {
		try {
			List<Employee> employeeList = employeeDao.findByName(name);
			if (employeeList.isEmpty() && employeeList.size() == 1)
				return employeeList.get(0);
			return null;
        } catch (DataAccessException e) {
            throw new ServiceException(e.getMessage(), e.getCause());
        }
	}

	@Override
	public Employee saveAndGet(Employee employee) throws ServiceException {
		Company company = employee.getCompany();
		try {
			Employee employee_old = employeeDao.getByCompanyAndEmployeeId(company.getId(), employee.getEmployeeId());
			if (null != employee_old) {
				employee_old.setName(employee.getName());
				employee_old.setPhone(employee.getPhone());
				employee_old.setEmail(employee.getEmail());
				employeeDao.update(employee_old);
                return employee_old;
			} else {
				employeeDao.save(employee);
                return employee;
			}
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}
	
}
