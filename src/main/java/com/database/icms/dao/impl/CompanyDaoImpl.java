package com.database.icms.dao.impl;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.database.icms.dao.CompanyDao;
import com.database.icms.domain.Company;

import java.util.*;

@Repository("CompanyDao")
public class CompanyDaoImpl extends BasicDaoImpl<Company> implements CompanyDao {

	@Override
	public Company getCompanyByName(String name) {
		String hql = "from Company c where c.name = ?";
		List<Company> companyList = this.findByHql(hql, new Object[] { name });
		if (null != companyList && companyList.size() == 1)
			return companyList.get(0);
		else
			return null;
	}
	
	@Override
	public boolean deleteById(String id) {
		Query query = getSession().createSQLQuery("delete from company where id = :ID");
        query.setString("ID",id);
        if(query.executeUpdate()== 0)
        {
        	return false;
        }
        else
        {
        	return true;
        }
	}
	
	@Override
	public Company getCompanyById(String id)
	{
		String hql = "from Company c where c.id = ? ";
		List<Company> companyList = this.findByHql(hql, new Object[]{Integer.parseInt(id)});
		if( null != companyList && companyList.size() == 1 ) return companyList.get(0);
		else return null;
	}

	@Override
	public List<Company> findCompanyByVagueName( String name ) {
		String hql = "from Company c where c.name like ?";
		List<Company> companyList = this.findByHql(hql, new Object[] { "%"+name+"%" });
		if (null != companyList)
			return companyList;
		else
			return null;
	}

}
