package com.database.icms.dao.impl;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.database.icms.dao.CompanyDao;
import com.database.icms.domain.Company;

import java.util.*;

@Repository("CompanyDao")
public class CompanyDaoImpl extends BasicDaoImpl<Company> implements CompanyDao {

	@Override
	public Company getCompanyByUsername(String username) {
		String hql = "from Company c where c.username = ?";
		List<Company> companyList = this.findByHql(hql, new Object[] { username });
		if (null != companyList && companyList.size() == 1)
			return companyList.get(0);
		else
			return null;
	}
	
	@Override
	public boolean deleteById(Integer id) {
		Query query = getSession().createSQLQuery("delete from company where id = :ID");
        query.setInteger("ID", id);
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
	public Company getCompanyById(Integer id)
	{
		String hql = "from Company c where c.id = ? ";
		List<Company> companyList = this.findByHql(hql, new Object[]{id});
		if( null != companyList && companyList.size() == 1 ) return companyList.get(0);
		else return null;
	}

	@Override
	public List<Company> findCompanyByVagueNameByPage( Integer pageNo,Integer pageSize,String name ) {
		String hql = "from Company c where c.name like ?";
		List<Company> companyList = this.findByPageHql(pageNo,pageSize,hql, new Object[] { "%"+name+"%" });
		if (null != companyList)
			return companyList;
		else
			return null;
	}

	@Override
	public Integer findCountByVagueName(String name) {
		String hql = "from Company c where c.name like ?";
		List<Company> companyList = this.findByHql(hql, new Object[] { "%"+name+"%" });
		if(companyList==null) return 0;
		return companyList.size();
	}

}
