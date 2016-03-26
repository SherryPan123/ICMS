package com.database.icms.service;

import java.util.List;

import com.database.icms.domain.Company;

public interface CompanyService {

	Company getCompanyByName(String name);
	
	Company getCompanyById(String id);
	
	//获得当前登陆公司
	Company getSessionCompany();

	void save(Company company);
	
	List<Company> findAllCompany();
	
	boolean deleteCompanyById(String id);
	
	void update(Company company);
}
