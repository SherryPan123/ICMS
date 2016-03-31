package com.database.icms.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.database.icms.dao.FareDao;
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

}
