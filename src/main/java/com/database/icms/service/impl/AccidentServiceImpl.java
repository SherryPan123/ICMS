package com.database.icms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.database.icms.dao.AccidentDao;
import com.database.icms.service.AccidentService;

public class AccidentServiceImpl implements AccidentService{

	@Autowired
	AccidentDao accidentDao ;
}
