package com.ljn.mall.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ljn.mall.domain.Category;
import com.ljn.mall.service.ICategoryService;
import com.ljn.mall.utils.UUIDUtils;


@Controller
public class CategoryController {

	@Autowired
	ICategoryService categoryService;
	
	@RequestMapping("/getAllCategorys")
	@ResponseBody
	public List<Category> getAllCategorys(){
		List<Category> categories=categoryService.selectAll();
		return categories;
	}
	
	//后台
	
	@RequestMapping("/selectAllCates")
	public String selectAllCates(Model model) {
		List<Category> categories=categoryService.selectAll();
		model.addAttribute("cate", categories);
		return "forward:/admin/category/list.jsp";
	}
	@RequestMapping("/addCategoryjsp")
	public String addCategoryjsp(){
		return "forward:/admin/category/add.jsp";
	}
	@RequestMapping("/addCategory")
	public String addCategory(@RequestParam("cname") String cname){
		Category category=new Category();
		category.setCid(UUIDUtils.getId());
		category.setCname(cname);
		categoryService.insert(category);
		//增加之后，重定向返回所有分类
		return "redirect:/selectAllCates";
	}
	
	@RequestMapping("/deleteCategory")
	public String deleteCategory(@RequestParam("cid") String cid){
		categoryService.deleteById(cid);
		return "redirect:/selectAllCates";
	}
	
	@RequestMapping("/modifyCategoryjsp")
	public String modifyCategoryjsp(@RequestParam("cid") String cid,Model model){
		Category category=categoryService.selectById(cid);
		model.addAttribute("cate", category);
		return "forward:/admin/category/edit.jsp";
	}
	@RequestMapping("/modifyCategory")
	public String modifyCategory(@RequestParam("cname") String cname,@RequestParam("cid") String cid,Model model){
		Category category=new Category();
		category.setCid(cid);
		category.setCname(cname);
		//System.out.println(category);
		categoryService.updateById(category);
		model.addAttribute("cate", category);
		return "redirect:/selectAllCates";
	}
}
