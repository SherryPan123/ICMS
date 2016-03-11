package com.database.icms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.database.icms.dao.UserDao;

@Service
public class UserService {

	@Autowired
	UserDao userDao;
	
}
