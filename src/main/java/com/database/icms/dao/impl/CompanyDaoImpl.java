package com.database.icms.dao.impl;

import org.springframework.stereotype.Repository;

import com.database.icms.dao.CompanyDao;
import com.database.icms.domain.Company;

import java.util.*;

@Repository("CompanyDao")
public class CompanyDaoImpl extends BasicDaoImpl<Company> implements CompanyDao {

	@Override
	public Company getCompanyByName(String name) {
		String hql = "from Company c where c.name = ?";
		List<Company> queryResult = this.findByHql(hql, new Object[] { name });
		if( queryResult.isEmpty() )
		{
			Company tmpCmy = new Company();
			tmpCmy.setName("无");
			tmpCmy.setAddress("无");
			tmpCmy.setPhone("无");
			return tmpCmy;
		}
		else
		{
			return this.findByHql(hql, new Object[] { name }).get(0);
		}
	}
	
}
