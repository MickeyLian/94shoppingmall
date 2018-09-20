package com.ljn.mall.dao;

import com.ljn.mall.domain.Orderitem;
import com.ljn.mall.domain.Orders;
import com.ljn.mall.domain.User;
import com.ljn.mall.utils.PageModel;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface IOrdersDao {
  
    int deleteById(String oid);
    int insert(Orders orders);	          
    Orders selectById(String oid);
    List<Orders> selectAll();
    int update(Orders orders);
    void saveOrder(Orders orders); 			//保存订单
    void saveOrderItem(Orderitem item);     //保存订单项
    int getTotalRecords(User user);			//获取订单总数
    List<Orders> findMyOrderWithPage(@Param("startIndex") int curPage,@Param("user") User user);  //分页查询我的订单
    List<Map<String, Object>> selectItemAndProduct(String oid);  //获取到每笔的订单id 查询每笔订单项以及订单项对应的商品信息
    Orders findOrderByOid(String oid);		//查询订单信息
    void deleteOrderByoid(String oid);      //根据oid取消订单
    void updateOrder(Orders order);			//修改订单（增加住址，电话，姓名，银行）
    
    List<Orders> findOrders();   //查询所有订单
    List<Orders> findOrderswithstate(String state);   //查询带有状态的所有订单   
}