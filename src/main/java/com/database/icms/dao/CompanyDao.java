package com.database.icms.dao;

import java.util.List;

import com.database.icms.domain.Company;

public interface CompanyDao extends BasicDao<Company> {

	Company getCompanyByName(String name);

}
