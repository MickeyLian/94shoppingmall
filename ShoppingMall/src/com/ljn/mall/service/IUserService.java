package com.ljn.mall.service;

import java.util.List;

import com.ljn.mall.domain.User;

public interface IUserService {

	  	int deleteById(String uid);
	    int insert(User user);
	    User selectById(String uid);
	    List<User> selectAll();
	    int update(User user);
	    boolean active(String code);
	    User selectLogin(User user);
	    int updatePassword(User user);
		String getpassword(String uid);		
		int updatePhoto(User user);	
}
