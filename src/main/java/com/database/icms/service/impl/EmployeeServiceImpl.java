package com.database.icms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.database.icms.dao.EmployeeDao;
import com.database.icms.service.EmployeeService;

public class EmployeeServiceImpl implements EmployeeService {


	@Autowired
	EmployeeDao employeeDao;
	
}
