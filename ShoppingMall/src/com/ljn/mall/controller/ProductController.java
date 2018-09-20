package com.ljn.mall.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.ljn.mall.domain.Category;
import com.ljn.mall.domain.Product;
import com.ljn.mall.service.ICategoryService;
import com.ljn.mall.service.IProductService;
import com.ljn.mall.utils.PageModel;
import com.ljn.mall.utils.UUIDUtils;
import com.ljn.mall.utils.UploadUtils;

@Controller
public class ProductController {

	@Autowired
	IProductService productService;
	@Autowired
	ICategoryService categoryService;
	
	@RequestMapping("/index")
	public String index(HttpServletRequest request) {
		List<Product> news=productService.selectNewProducts();
		List<Product> hots=productService.selectHotProducts();
		request.setAttribute("news", news);
		request.setAttribute("hots", hots);
		return "index";
	}
	@RequestMapping("/findProById")
	public String findProById(@RequestParam(value="pid") String pid,Model model){
		Product product=productService.selectByid(pid);
		model.addAttribute("product", product);
		return "product_info";
	}
	
	@RequestMapping("/selectBycidWithPage")
	public String selectBycid(@RequestParam(value="cid") String cid,@RequestParam(value="curPage") int curPage,Model model){
		PageModel pm =productService.selectBycidWithPage(cid, curPage);
		model.addAttribute("page", pm);
		return "product_list";
	}
	
	//后台
	//查询所有商品
	@RequestMapping("/findAllProductsWithPage")
	public String findAllProductsWithPage(@RequestParam("curPage") int curPage,Model model){
		PageModel pm=productService.findAllProductsWithPage(curPage);
		model.addAttribute("page", pm);
		return "forward:/admin/product/list.jsp";
	}
	
	//下架
	@RequestMapping("/addDownProduct")
	public String addDownProduct(@RequestParam("pid") String pid,@RequestParam("curPage") int curPage,Model model) {
		Product product=productService.selectByid(pid);
		product.setPflag(1);
		productService.updatepflagByID(product);
		PageModel pm=productService.findAllProductsWithPage(curPage);
		model.addAttribute("page", pm); 
		return "forward:/admin/product/list.jsp";
	}
	//查询已下架商品
	@RequestMapping("/findDownProduct")
	public String findDownProduct(Model model,@RequestParam("curPage") int curPage){
		PageModel pm=productService.selectBypflag(curPage);
		model.addAttribute("page", pm);
		return "forward:/admin/product/pushDown_list.jsp";
	}
	//上架
	@RequestMapping("/upProduct")
	public String upProduct(@RequestParam("pid") String pid,@RequestParam("curPage") int curPage,Model model) {
		Product product=productService.selectByid(pid);
		product.setPflag(0);
		productService.updatepflagTo0ByID(product);
		PageModel pm=productService.selectBypflag(curPage);
		model.addAttribute("page", pm); 
		return "forward:/admin/product/list.jsp";
	}
	
	//增加商品（上传）
	//先进入增加商品界面,查询所有分类，存入request
	@RequestMapping("/addProductjsp")
	public String addProductjsp(Model model){
		List<Category> categories=categoryService.selectAll();
		model.addAttribute("cates", categories);
		return "forward:/admin/product/add.jsp";
	}
	//增加商品
	@RequestMapping(value="/addProduct")
	public String addProduct(HttpServletRequest request, MultipartFile pimage) throws Exception {
		Product product=new Product();
		//存储表单中数据
		Map<String, String[]> map= request.getParameterMap();
		//获取上传项
		CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(request.getSession().getServletContext());
		if (multipartResolver.isMultipart(request)) {
			MultipartHttpServletRequest multiRequest =(MultipartHttpServletRequest) request;
			Iterator<String> iter = multiRequest.getFileNames();
			// 遍历迭代器
			while (iter.hasNext()) {
				// 获取文件
				pimage = multiRequest.getFile((String) iter.next());
				if (pimage != null) {
					// 文件的名字
					//D:\tomcat\tomcat71_sz07\webapps\store_v5\products\3
					//String realPath=request.getSession().getServletContext().getRealPath("/products/3/");
					String  realPath="D:/eclipseWorkspace2/ShoppingMall/WebContent/products/3/";
					String path = realPath + pimage.getOriginalFilename();
					System.out.println(path);
					product.setPimage("products/3/"+pimage.getOriginalFilename());
					// 上传路径
					File localFile = new File(path);
					if (!localFile.exists()) {
						localFile.mkdirs();
					}
					pimage.transferTo(localFile);
				}
			}
		}
		BeanUtils.populate(product, map);
		product.setPid(UUIDUtils.getId());
		product.setPdate(new Date());
		product.setPflag(0);
		System.out.println(product);
		productService.insert(product);
		return "redirect:findAllProductsWithPage?curPage=1";
	}

	//先到编辑商品页面
	@RequestMapping("/modefyProductjsp")
	public String modefyProductjsp(@RequestParam("pid") String pid,Model model){
		Product product=productService.selectByid(pid);
		model.addAttribute("product", product);
		List<Category> categories=categoryService.selectAll();
		model.addAttribute("cates", categories);
		return "forward:/admin/product/edit.jsp";
	}
	//修改商品
	@RequestMapping("/modefyProduct")
	public String modefyProduct(HttpServletRequest request, MultipartFile pimage, Model model) throws Exception {
		String pid=request.getParameter("pid");
		Product product = new Product();
		// 存储表单中数据
		Map<String, String[]> map = request.getParameterMap();
		// 获取上传项
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());
		if (multipartResolver.isMultipart(request)) {
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			Iterator<String> iter = multiRequest.getFileNames();
			// 遍历迭代器
			while (iter.hasNext()) {
				// 获取文件
				pimage = multiRequest.getFile((String) iter.next());
				if (pimage != null) {
					// 文件的名字
					// D:\tomcat\tomcat71_sz07\webapps\store_v5\products\3
					// String realPath=request.getSession().getServletContext().getRealPath("/products/3/");
					String realPath = "D:/eclipseWorkspace2/ShoppingMall/WebContent/products/3/";
					String path = realPath + pimage.getOriginalFilename();
					System.out.println(path);
					product.setPimage("products/3/" + pimage.getOriginalFilename());
					// 上传路径
					File localFile = new File(path);
					if (!localFile.exists()) {
						localFile.mkdirs();
					}
					pimage.transferTo(localFile);
				}
			}
		}
		BeanUtils.populate(product, map);
		product.setPid(pid);
		product.setPdate(new Date());
		product.setPflag(0);
		model.addAttribute("product", product);
		productService.updateByid(product);
		System.out.println(product);
		return "redirect:/findAllProductsWithPage?curPage=1";
	}
	
}
