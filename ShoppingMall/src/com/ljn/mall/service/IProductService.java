package com.ljn.mall.service;

import java.util.List;

import com.ljn.mall.domain.Comment;
import com.ljn.mall.domain.Product;
import com.ljn.mall.domain.Reply;
import com.ljn.mall.utils.PageModel;

public interface IProductService {

	int deleteByid(String pid);
    int insert(Product product);
    Product selectByid(String pid);			//根据id查询商品
    List<Product> selectAll();
    int updateByid(Product product);
    
    List<Product> selectNewProducts();		//查询商品表中最新的9件商品信息
    List<Product> selectHotProducts();		//查询商品表中最热最新的9件商品信息
    PageModel selectBycidWithPage(String cid,int curPage);			//查询分类id的商品信息所在的当前页
    PageModel findAllProductsWithPage(int curPage);					//查询所有商品所在的当前页
    int updatepflagByID(Product product);				//将商品下架 修改商品的属性pflag
    PageModel selectBypflag(int curPage);   //查询已下架商品（pflag=1）
    int updatepflagTo0ByID(Product product);				//将商品上架架 修改商品的属性pflag
    PageModel findProduct(String key,int index);		//模糊查询 搜索
    //评论模块
    void insertComment(Comment comment);    //添加一条评论
    void insertReply(Reply reply);			//添加一条回复
    List<Comment> findComments();				//根据pid查询评论列表
    List<Reply>  findReplys(); 				//根据pid查询回复列表
}
