package com.ljn.mall.service;


import java.util.List;

import com.ljn.mall.domain.Orders;
import com.ljn.mall.domain.User;
import com.ljn.mall.utils.PageModel;

public interface IOrderService {

	void saveOrder(Orders orders); 			//保存订单
    PageModel findMyOrderWithPage(int curPage,User user);  //分页查询我的订单
    Orders findOrderByOid(String oid);		//查询订单信息
    void deleteOrderByoid(String oid);      //根据oid取消订单
    void updateOrder(Orders order);			//修改订单（增加住址，电话，姓名，银行）
    
    List<Orders> findOrders();
    List<Orders> findOrdersWithState(String state);
}
