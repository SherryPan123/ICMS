package com.database.icms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.database.icms.dao.CompanyDao;
import com.database.icms.domain.Company;
import com.database.icms.service.CompanyService;

import antlr.collections.List;

@Service
public class CompanyServiceImpl implements CompanyService {

	@Autowired
	CompanyDao companyDao;
	
	@Override
	public Company getCompanyByName(String name) {
		return companyDao.getCompanyByName(name);
	}
	
}
