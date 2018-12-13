package com.ljn.mall.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ljn.mall.domain.Comment;
import com.ljn.mall.domain.Product;
import com.ljn.mall.domain.Reply;
import com.ljn.mall.utils.PageModel;

public interface IProductDao {
    int deleteById(String pid);											//根据id删除商品信息
    int insert(Product product);
    Product selectById(String pid);
    List<Product> selectAll();
    int updateById(Product product);
    
    List<Product> selectNewProducts();									//查询商品表中最新的9件商品信息
    List<Product> selectHotProducts();									//查询商品表中最热最新的9件商品信息
    List selectBycidWithPage(@Param("cid")String cid,@Param("startIndex")int index);	//查询分类id的商品信息
    int pagecount(String cid);			//获取总的页数
    List<Product> findAllProductsWithPage(int curPage);				//查询所有商品信息
    int findTotalCount();               //获取总的商品数量
    int updatepflagByID(Product product);				//将商品下架 修改商品的属性pflag
    List<Product> selectBypflag(int curPage);   //查询已下架商品（pflag=1）分页
    int findDownProCount();                   //查询下架商品数量
    int updatepflagTo0ByID(Product product);				//将商品上架架 修改商品的属性pflag
    List<Product> findProduct(@Param("key")String key,@Param("startIndex")int index);		//模糊查询 搜索
    int findkeyProductCount(String key);
    //评论模块
    void insertComment(Comment comment);    //添加一条评论
    void insertReply(Reply reply);			//添加一条回复
    List<Comment> findComments();				//根据pid查询评论列表
    List<Reply>  findReplys(); 				//根据pid查询回复列表
    
}