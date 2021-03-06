package com.database.icms.dao;

import com.database.icms.domain.Company;
import java.util.*;

public interface CompanyDao extends BasicDao<Company> {

	Company getCompanyByUsername(String username);
	
	//通过id删除公司
	public boolean deleteById(Integer id);
	
	//通过id得到公司
	Company getCompanyById(Integer id);
	
	//通过名字模糊查询公司
	List<Company> findCompanyByVagueNameByPage( Integer pageNo, Integer pageSize, String name );
	
	//通过名字模糊查询得到公司数量
	Integer findCountByVagueName(String name);
}
