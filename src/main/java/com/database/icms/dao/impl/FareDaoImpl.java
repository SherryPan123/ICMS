package com.database.icms.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.database.icms.dao.FareDao;
import com.database.icms.domain.Company;
import com.database.icms.domain.Fare;

@Repository
public class FareDaoImpl extends BasicDaoImpl<Fare> implements FareDao {

	@Override
	public Fare getFareById(Integer id) {
		// TODO Auto-generated method stub
		String hql = "from Fare f where f.id = ? ";
		List<Fare> fareList = this.findByHql(hql, new Object[]{id});
		if( null != fareList && fareList.size() == 1 ) return fareList.get(0);
		else return null;
	}
	
}
