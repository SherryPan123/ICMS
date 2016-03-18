package com.database.icms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.database.icms.dao.EmployeeDao;
import com.database.icms.service.EmployeeService;

@Service
public class EmployeeServiceImpl implements EmployeeService {


	@Autowired
	EmployeeDao employeeDao;
	
}
