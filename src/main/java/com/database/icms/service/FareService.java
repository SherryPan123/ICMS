package com.database.icms.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.database.icms.domain.Fare;


@Service
public interface FareService {

	List<Fare> findAllFare();
	
	List<Fare> findAllFareByPage( Integer pageNo,Integer pageSize );
	
	List<Fare> findCompanyFareByPage(Integer companyId ,Integer page,Integer pageSize);
	
	List<Fare> findAllFareByCompany(Integer companyId);
	
	void save(Fare fare) ;
	
	Fare getFareById(Integer id);
	
	void update(Fare fare_be_updated);
	
	void deleteFareById(Integer id);
	
	List<Fare> listDetail(Integer companyId, String plateNumber, String type,Date startTime,Date endTime ,int i,Integer max);
	
	Integer listAllDetailSize(Integer companyId, String plateNumber,String type,Date starTime,Date endTime);
	
	List<Fare> listDetailGraph(Integer companyId, String fareType, Date startTime, Date endTime);

}
