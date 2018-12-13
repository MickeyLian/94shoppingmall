package com.ljn.mall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ljn.mall.dao.IProductDao;
import com.ljn.mall.domain.Comment;
import com.ljn.mall.domain.Product;
import com.ljn.mall.domain.Reply;
import com.ljn.mall.service.IProductService;
import com.ljn.mall.utils.PageModel;
@Service
public class ProductServiceImpl implements IProductService {

	@Autowired
	IProductDao productDao;
	
	@Override
	public int deleteByid(String pid) {
		
		return productDao.deleteById(pid);
	}

	@Override
	public int insert(Product product) {
		
		return productDao.insert(product);
	}

	@Override
	public Product selectByid(String pid) {
		
		return productDao.selectById(pid);
	}

	@Override
	public List<Product> selectAll() {
		
		return productDao.selectAll();
	}

	@Override
	public int updateByid(Product product) {
		return productDao.updateById(product);
	}

	@Override
	public List<Product> selectNewProducts() {
		
		return productDao.selectNewProducts();
	}

	@Override
	public List<Product> selectHotProducts() {
		
		return productDao.selectHotProducts();
	}

	@Override
	public PageModel selectBycidWithPage(String cid, int curPage) {
		//创建PageModel对象，目的：计算分页参数
		int totalRecords=productDao.pagecount(cid);
		//调用构造函数（带有当前页，总页数，每页显示的条数）
		PageModel model=new PageModel(curPage, totalRecords, 12);
		//关联集合
		List list = productDao.selectBycidWithPage(cid, model.getStartIndex()); 
		model.setList(list);
		//关联URL
		model.setUrl("selectBycidWithPage?cid="+cid);
		return model;
	}

	@Override
	public PageModel findAllProductsWithPage(int curPage) {
		int totalRecords=productDao.findTotalCount();
		//System.out.println(totalRecords);
		PageModel pm=new PageModel(curPage, totalRecords, 6);
		List<Product> products=productDao.findAllProductsWithPage(pm.getStartIndex());
		pm.setList(products);
		pm.setUrl("findAllProductsWithPage");
		//System.out.println(products);
		return pm;
	}

	@Override
	public int updatepflagByID(Product product) {
		
		return productDao.updatepflagByID(product);
	}

	@Override
	public PageModel selectBypflag(int curPage) {
		int totalRecords=productDao.findDownProCount();
		//System.out.println(totalRecords);
		PageModel pm=new PageModel(curPage, totalRecords, 6);
		List<Product> products=productDao.selectBypflag(pm.getStartIndex());
		pm.setList(products);
		pm.setUrl("findDownProduct");
		//System.out.println(products);
		return pm;
	}

	@Override
	public int updatepflagTo0ByID(Product product) {
		
		return productDao.updatepflagTo0ByID(product);
	}

	@Override
	public PageModel findProduct(String key,int index) {
		int totalRecords=productDao.findkeyProductCount(key);
		PageModel pm=new PageModel(index, totalRecords, 12);
		List<Product> list=productDao.findProduct(key, pm.getStartIndex());
		pm.setList(list);
		pm.setUrl("findProductByKey?key="+key);
		return pm;
	}

	/**
	 * 增加一条评论
	 */
	@Override
	public void insertComment(Comment comment) {
		
		productDao.insertComment(comment);
	}

	/**
	 * 增加一条回复
	 */
	@Override
	public void insertReply(Reply reply) {
		
		productDao.insertReply(reply);
	}

	/**
	 * 查询评论列表
	 */
	@Override
	public List<Comment> findComments() {
		
		return productDao.findComments();
	}

	/**
	 * 查询回复列表
	 */
	@Override
	public List<Reply> findReplys() {
		
		return productDao.findReplys();
	}



	

}
