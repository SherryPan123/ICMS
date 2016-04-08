package com.database.icms.dao;

import java.util.Date;
import java.util.List;

import com.database.icms.domain.Fare;

public interface FareDao extends BasicDao<Fare>{

	Fare getFareById(Integer id);

	List<Fare> list(int first, Integer max);

	List<Fare> listDetail(Integer companyId, String plateNumber,String type,Date startTime,Date endTime,int first,Integer max);

	Integer listAllDetailSize(Integer companyId, String plateNumber,String type,Date startTime,Date endTime);
	
}
