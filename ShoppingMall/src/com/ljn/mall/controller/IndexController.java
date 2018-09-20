package com.ljn.mall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ljn.mall.domain.Product;
import com.ljn.mall.service.IProductService;
import com.ljn.mall.utils.PageModel;

@Controller
public class IndexController {

	@Autowired
	IProductService productService;
	
	@RequestMapping("/")
	public String index() {
		return "index";
	}
	
	@RequestMapping("/findProductByKey")
	public String findProductByKey(@RequestParam("key") String key,@RequestParam("curPage") int curPage,Model model ){
		PageModel pm=productService.findProduct(key, curPage);
		model.addAttribute("page", pm);
		return "product_list";
	}
}
