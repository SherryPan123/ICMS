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
	public Company getCompanyByUsername(String username) {
		return companyDao.getCompanyByUsername(username);
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
	public List<Company> findAllCompany() {
		List<Company> companyList = companyDao.findAll(Company.class);
		if (companyList != null)
			return companyList;
		else
			return null;
	}

	@Override
	public boolean deleteCompanyById(Integer id) {
		if (companyDao.deleteById(id)) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public void update(Company company) {
		companyDao.saveOrUpdate(company);
	}

	@Override
	public Company getCompanyById(Integer id) {
		return companyDao.getCompanyById(id);
	}

	@Override
	public List<Company> findAllCompanyByPage( Integer pageNo ,Integer pageSize) {
		return companyDao.findByPageHql(pageNo,pageSize,"from "+Company.class.getSimpleName());
	}

	@Override
	public List<Company> findCompanyByVagueName(String name) {
		return companyDao.findCompanyByVagueName(name);
	}

}
