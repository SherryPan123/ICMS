package com.database.icms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.database.icms.dao.CompanyDao;
import com.database.icms.service.CompanyService;

public class CompanyServiceImpl implements CompanyService {

	@Autowired
	CompanyDao companyDao ;
}
