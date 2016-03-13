package com.database.icms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.database.icms.dao.CarDao;
import com.database.icms.service.CarService;


public class CarServiceImpl implements CarService {
	@Autowired
	CarDao carDao ;
	
}
