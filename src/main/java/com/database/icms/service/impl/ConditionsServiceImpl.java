package com.database.icms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.database.icms.dao.ConditionsDao;
import com.database.icms.service.ConditionsService;

public class ConditionsServiceImpl implements ConditionsService{

	@Autowired
	ConditionsDao conditionsDao ;
}
