package com.database.icms.service;

import java.util.List;

import com.database.icms.domain.Company;

public interface CompanyService {

	//通过用户名得到公司
	Company getCompanyByUsername(String username);
	
	//同过id获得公司
	Company getCompanyById(Integer id);
	
	//获得当前登陆公司
	Company getSessionCompany();

	//保存公司实体
	void save(Company company);
	
	//列出所有的公司
	List<Company> findAllCompany();
	
	//分页形式列出所有公司
	List<Company> findAllCompanyByPage( Integer pageNo,Integer pageSize );
	
	//根据id删除公司
	boolean deleteCompanyById(Integer id);
	
	//更新公司信息
	void update(Company company);
	
	//通过名字模糊查询公司
	List<Company> findCompanyByVagueNameByPage( Integer pageNo,Integer pageSize,String name );
	
	//通过名字模糊查询得到公司数量
	Integer findCountByVagueName(String name);
}
