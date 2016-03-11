package com.database.icms.dao;

import java.util.List;

import com.database.icms.domain.User;

public interface UserDao {
	
	User findById(Integer id);
	 
    void saveUser(User user);
     
    List<User> findAllUsers();
    
}
