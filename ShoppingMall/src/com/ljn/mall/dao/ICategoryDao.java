package com.ljn.mall.dao;

import java.util.List;

import com.ljn.mall.domain.Category;

public interface ICategoryDao {
   
    int deleteById(String cid);				//删除分类
    int insert(Category category);			//增加分类
    Category selectById(String cid);
    List<Category> selectAll();				//查询所有分类信息
    void updateById(Category category);
}