package com.ljn.mall.service;

import java.util.List;

import com.ljn.mall.domain.Category;

public interface ICategoryService {

	int deleteById(String cid);
    int insert(Category category);
    Category selectById(String cid);
    List<Category> selectAll();
    void updateById(Category category);
}
