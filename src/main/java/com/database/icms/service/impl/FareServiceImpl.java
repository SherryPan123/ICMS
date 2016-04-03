package com.database.icms.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.database.icms.dao.FareDao;
import com.database.icms.domain.Car;
import com.database.icms.domain.Company;
import com.database.icms.domain.Fare;
import com.database.icms.service.FareService;

@Service
@Transactional
public class FareServiceImpl implements FareService{
	@Autowired
	FareDao fareDao ;
	@Override
	public List<Fare> findAllFareByPage( Integer pageNo ,Integer pageSize) {
		// TODO Auto-generated method stub
		return fareDao.findByPageHql(pageNo,pageSize,"from "+Fare.class.getSimpleName());
	}
	@Override
	public List<Fare> findAllFare(){
		return  fareDao.findAll(Fare.class);
	}
	
	@Override
	public List<Fare> findCompanyFareByPage(Integer companyId,Integer pageNo ,Integer pageSize)
	{
		//根据公司ID查询费用		
		String fare = Fare.class.getSimpleName() ;
//		String car = Car.class.getSimpleName();
//		String company = Company.class.getSimpleName();
		//String hql = "from "+fare+" where car_id in (select id from "+car+" where company_id in (select id from "+company+" where id="+companyId+"))"  ;
		String hql = "from "+fare+" f where f.car.company.id = "+companyId; 
		return fareDao.findByPageHql(pageNo, pageSize, hql) ;
	}
	@Override
	public List<Fare> findAllFareByCompany(Integer companyId) {
		// TODO Auto-generated method stub
		String fare = Fare.class.getSimpleName() ;
		String hql = "from "+fare+" f where f.car.company.id = "+companyId;
		return fareDao.findByHql(hql);
	}
}
