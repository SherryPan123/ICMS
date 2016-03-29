package com.database.icms.dao;

import com.database.icms.domain.Company;

public interface CompanyDao extends BasicDao<Company> {

	Company getCompanyByName(String name);
	
	public boolean deleteById(String id);
	
	Company getCompanyById(Integer id);

}
