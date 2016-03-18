package com.database.icms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.database.icms.dao.CarDao;
import com.database.icms.domain.Car;
import com.database.icms.service.CarService;
import com.database.icms.service.CompanyService;

@Service
public class CarServiceImpl implements CarService {
	
	@Autowired
	CarDao carDao ;
	
	@Autowired
	CompanyService companyService;

	@Override
	public void saveCarForm(Car car) {
		car.setCompany(companyService.getSessionCompany());
		car.setStatus(0);  //0
		carDao.save(car);
	}
	
}
