package com.ljn.mall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ljn.mall.dao.IUserDao;
import com.ljn.mall.domain.User;
import com.ljn.mall.service.IUserService;
@Service
public class UserServiceImpl implements IUserService {

	@Autowired
	IUserDao userDao;
	@Override
	public int deleteById(String uid) {
		return userDao.deleteById(uid);
	}

	@Override
	public int insert(User user) {
		return userDao.insert(user);
	}

	@Override
	public User selectById(String uid) {
		return userDao.selectById(uid);
	}

	@Override
	public List<User> selectAll() {
		return userDao.selectAll();
	}

	@Override
	public int update(User user) {
		return userDao.update(user);
	}

	@Override
	public boolean active(String code) {
		//根据激活码查找到一个用户
		User user=userDao.active(code);
		if (user!=null) {
			//修改用户状态，清空激活码
			user.setState(1);
			user.setCode(null);
			userDao.update(user);
			return true;
		}else{
			return false;
		}
	}

	@Override
	public User selectLogin(User user) {
		User uu=userDao.selectLogin(user);
		//判断用户是否正确(可能密码错误，状态未激活，账号错误（通过ajax）)
		if (uu==null) {
			throw new RuntimeException("密码错误！");
		}else if (uu.getState()==0) {
			throw new RuntimeException("用户未激活!");
		}else {
			return uu;
		}
	}

}
