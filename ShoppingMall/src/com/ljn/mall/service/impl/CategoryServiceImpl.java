package com.ljn.mall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ljn.mall.dao.ICategoryDao;
import com.ljn.mall.domain.Category;
import com.ljn.mall.service.ICategoryService;
@Service
public class CategoryServiceImpl implements ICategoryService {

	@Autowired
	ICategoryDao categoryDao;
	@Override
	public int deleteById(String cid) {
		
		return categoryDao.deleteById(cid);
	}

	@Override
	public int insert(Category category) {
		
		return categoryDao.insert(category);
	}

	@Override
	public Category selectById(String cid) {
		
		return categoryDao.selectById(cid);
	}

	@Override
	public List<Category> selectAll() {
		return categoryDao.selectAll();
	}

	@Override
	public void updateById(Category category) {
		
		categoryDao.updateById(category);
		//System.out.println(category.getCid());
	}

}
