package com.database.icms.service;

import java.util.List;

import com.database.icms.domain.Company;

public interface CompanyService {

	//通过用户名得到公司
	Company getCompanyByUsername(String username);
	
	//同过id获得公司
	Company getCompanyById(int id);
	
	//获得当前登陆公司
	Company getSessionCompany();

	void save(Company company);
	
	List<Company> findAllCompany();
	
	List<Company> findAllCompanyByPage( Integer pageNo,Integer pageSize );
	
	boolean deleteCompanyById(Integer id);
	
	void update(Company company);
	
	//通过名字模糊查询公司
	List<Company> findCompanyByVagueName( String name );
}
