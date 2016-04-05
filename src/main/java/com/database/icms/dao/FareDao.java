package com.database.icms.dao;

import com.database.icms.domain.Fare;

public interface FareDao extends BasicDao<Fare>{

	Fare getFareById(Integer id);
	
}
