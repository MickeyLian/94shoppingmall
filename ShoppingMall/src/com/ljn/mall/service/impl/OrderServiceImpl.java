package com.ljn.mall.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ljn.mall.dao.IOrdersDao;
import com.ljn.mall.domain.Orderitem;
import com.ljn.mall.domain.Orders;
import com.ljn.mall.domain.Product;
import com.ljn.mall.domain.User;
import com.ljn.mall.service.IOrderService;
import com.ljn.mall.utils.PageModel;

@Service
public class OrderServiceImpl implements IOrderService {

	@Autowired
	IOrdersDao ordersDao;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void saveOrder(Orders orders) {
		ordersDao.saveOrder(orders);
		for (Orderitem item : orders.getList()) {
			ordersDao.saveOrderItem(item);
		}

	}

	@Override
	public PageModel findMyOrderWithPage(int curPage, User user) {
		// 创建PageModel对象，目的：计算分页参数
		int totalRecords = ordersDao.getTotalRecords(user);
		PageModel pm = new PageModel(curPage, totalRecords, 3);
		// 关联集合
		List<Orders> list = ordersDao.findMyOrderWithPage(pm.getStartIndex(), user);
		// System.out.println("list1:"+list);
		for (Orders orders : list) {
			List<Map<String, Object>> list2 = ordersDao.selectItemAndProduct(orders.getOid());
			// System.out.println("list2:"+list2);
			for (Map<String, Object> map : list2) {
				Orderitem item = new Orderitem();
				Product product = new Product();
				DateConverter dt = new DateConverter();
				// 设置转换的格式
				dt.setPattern("yyyy-MM-dd");
				// 注册转换器
				ConvertUtils.register(dt, java.util.Date.class);
				try {
					BeanUtils.populate(item, map);
					BeanUtils.populate(product, map);
					item.setProduct(product);
					orders.getList().add(item);
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}
			}
		}
		pm.setList(list);
		// 关联URL
		pm.setUrl("findMyOrderWithPage");
		return pm;
	}

	@Override
	public void deleteOrderByoid(String oid) {
		ordersDao.deleteOrderByoid(oid);

	}

	@Override
	public Orders findOrderByOid(String oid) {
		Orders order = ordersDao.findOrderByOid(oid);
		List<Map<String, Object>> list2 = ordersDao.selectItemAndProduct(oid);
		for (Map<String, Object> map : list2) {
			Orderitem item = new Orderitem();
			Product product = new Product();
			DateConverter dt = new DateConverter();
			// 设置转换的格式
			dt.setPattern("yyyy-MM-dd");
			// 注册转换器
			ConvertUtils.register(dt, java.util.Date.class);
			try {
				BeanUtils.populate(item, map);
				BeanUtils.populate(product, map);
				item.setProduct(product);
				order.getList().add(item);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return order;
	}

	@Override
	public void updateOrder(Orders order) {
		ordersDao.updateOrder(order);
		
	}

	@Override
	public List<Orders> findOrders() {
		
		return ordersDao.findOrders();
	}

	@Override
	public List<Orders> findOrdersWithState(String state) {
		
		return ordersDao.findOrderswithstate(state);
	}

}
