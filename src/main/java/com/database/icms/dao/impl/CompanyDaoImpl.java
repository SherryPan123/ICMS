package com.database.icms.dao.impl;

import org.springframework.stereotype.Repository;

import com.database.icms.dao.CompanyDao;
import com.database.icms.domain.Company;

@Repository("CompanyDao")
public class CompanyDaoImpl extends BasicDaoImpl<Company> implements CompanyDao {

	@Override
	public Company getCompanyByName(String name) {
		String hql = "from Company c where c.name = ?";
		return (Company) this.findByHql(hql, new Object[] { name });
		
	}
	
}