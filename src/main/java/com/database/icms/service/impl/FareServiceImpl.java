package com.database.icms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.database.icms.dao.FareDao;
import com.database.icms.service.FareService;

public class FareServiceImpl implements FareService{
	@Autowired
	FareDao fareDao ;
}
