package com.database.icms.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.database.icms.dao.CompanyDao;
import com.database.icms.domain.Company;
import com.database.icms.service.CompanyService;

@Service
@Transactional
public class CompanyServiceImpl implements CompanyService {

	@Autowired
	CompanyDao companyDao;
	
	@Override
	public Company getCompanyByName(String name) {
		return companyDao.getCompanyByName(name);
	}

	@Override
	public Company getSessionCompany() {
		return (Company) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	}

	@Override
	public void save(Company company) {
		companyDao.save(company);
	}
	
	@Override
	public List<Company> findAllCompany()
	{
		return companyDao.findAll(Company.class);
	}

	@Override
	public boolean deleteCompanyById( String id ) {
		if( companyDao.deleteById(id))
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	@Override
	public void update(Company company) {
		// TODO Auto-generated method stub
		companyDao.saveOrUpdate(company);
	}
	
}
