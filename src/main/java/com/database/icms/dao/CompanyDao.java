package com.database.icms.dao;

import com.database.icms.domain.Company;
import java.util.*;

public interface CompanyDao extends BasicDao<Company> {

	Company getCompanyByName(String name);
	
	public boolean deleteById(String id);
	
	Company getCompanyById(String id);
	
	//通过名字模糊查询公司
	List<Company> findCompanyByVagueName( String name );
}
