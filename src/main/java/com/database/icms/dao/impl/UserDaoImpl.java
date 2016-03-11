package com.database.icms.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.database.icms.dao.BasicDao;
import com.database.icms.dao.UserDao;
import com.database.icms.domain.User;

@Repository
public class UserDaoImpl extends BasicDao<Integer, User> implements UserDao {

	public User findById(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

	public void saveUser(User user) {
		// TODO Auto-generated method stub
		
	}

	public List<User> findAllUsers() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
