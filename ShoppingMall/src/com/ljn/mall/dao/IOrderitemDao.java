package com.ljn.mall.dao;

import com.ljn.mall.domain.Orderitem;
import java.util.List;

public interface IOrderitemDao {
   
    int deleteById(String itemid);
    int insert(Orderitem orderitem);	    	//保存订单项
    Orderitem selectById(String itemid);
    List<Orderitem> selectAll();
    int update(Orderitem record);
}