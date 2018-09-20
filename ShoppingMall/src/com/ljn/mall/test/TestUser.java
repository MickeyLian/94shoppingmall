package com.ljn.mall.test;

import java.util.Date;

import org.junit.Test;

import com.ljn.mall.domain.User;
import com.ljn.mall.service.IUserService;

public class TestUser {

	IUserService userService;
	@Test
	public void testinsert(){
		//没有相应的配置文件，会导致空指针异常 
		Date date=new Date();
		User user =new User("1", "2", "3", "4", "4", "4", date, "2", 0, "2");
		System.out.println(userService.insert(user));
	}
}
