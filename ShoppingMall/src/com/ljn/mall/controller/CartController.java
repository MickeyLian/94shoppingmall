package com.ljn.mall.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.ljn.mall.domain.Cart;
import com.ljn.mall.domain.CartItem;
import com.ljn.mall.domain.Product;
import com.ljn.mall.service.IProductService;

@Controller
@SessionAttributes("cart")
public class CartController {

	@Autowired
	IProductService productService;
	/**
	 * 增加商品到购物车
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/addCartItemToCart")
	public String addCartItemToCart(Model model,HttpServletRequest request){
		HttpSession session=request.getSession();
		Cart cart=(Cart) session.getAttribute("cart");
		if (cart==null) {
			cart=new Cart();
			session.setAttribute("cart", cart);
		}
		//获取商品pid,数量
		String pid=request.getParameter("pid");
		int num=Integer.parseInt(request.getParameter("quantity"));
		//根据pid获取到商品对象
		Product product=productService.selectByid(pid);
		//获取到待购买的购物项
		CartItem cartItem=new CartItem();
		cartItem.setNum(num);
		cartItem.setProduct(product);
		//调用购物车的方法
		cart.addCartItemToCar(cartItem);
		//重定向到cart.jsp
		return "redirect:/jsp/cart.jsp";
	}
	
	/**
	 * 移除一个购物项
	 * @param pid
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/removeCartItem")
	public String removeCartItem(@RequestParam("pid") String pid,Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		Cart cart=(Cart) session.getAttribute("cart");
		cart.removeCartItem(pid);
		return "redirect:/jsp/cart.jsp";
	}
	/**
	 * 清空购物车
	 * @param request
	 * @return
	 */
	@RequestMapping("/ClearCart")
	public String ClearCart(HttpServletRequest request){
		HttpSession session=request.getSession();
		Cart cart=(Cart) session.getAttribute("cart");
		cart.clearCart();
		return "redirect:/jsp/cart.jsp";
	}
	
}
