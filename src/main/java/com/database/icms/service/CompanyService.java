package com.database.icms.service;

import com.database.icms.domain.Company;

public interface CompanyService {

	Company getCompanyByName(String name);
	
	//获得当前登陆公司
	Company getSessionCompany();

	void save(Company company);

}
