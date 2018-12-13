package com.ljn.mall.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.ljn.mall.domain.User;
import com.ljn.mall.service.IUserService;
import com.ljn.mall.utils.MailUtils;
import com.ljn.mall.utils.MyBeanUtils;
import com.ljn.mall.utils.UUIDUtils;

@Controller
public class UserController {

	@Autowired
	IUserService userService;

	
	@RequestMapping("/checkImg")
	@ResponseBody
	public String checkImg(Model model,HttpServletRequest request,HttpServletResponse response) throws IOException {
		//建立图像缓冲区
		BufferedImage bi=new BufferedImage(80, 32, BufferedImage.TYPE_INT_RGB);
		//建立绘制图片的对象
		Graphics g=bi.getGraphics();
		//获取颜色
		Color c=new Color(240, 230, 140);
		g.setColor(c);
		//设置图片位置及大小
		g.fillRect(0, 0, 80, 32);
		//设置随机产生的字符范围
		char ch[]="0123456789".toCharArray();
		//新建随机数对象，在所给字符串长度内生成随机数，通过对应位置读出对应字符
		StringBuffer sb=new StringBuffer();
		Random random=new Random();
		int len=ch.length;
		//建立1验证码字符串对象，并添加至4个（设置验证码为4个字符）
		for(int i=0;i<4;i++){
			int index=random.nextInt(len);
			//随机设定当前字符颜色
			g.setFont(new Font("宋体",Font.BOLD, 15));
			g.setColor(new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255)));
			g.drawString(ch[index]+"",i*15+9 , 20);
			sb.append(ch[index]);
		}
		request.getSession().setAttribute("picCode",sb.toString());
		//System.out.println(sb.toString());
		ImageIO.write(bi,"JPG", response.getOutputStream());
		return null;
	}
	
	@RequestMapping("/register")
	public String register(){
		return "register";
	}
	/**
	 * 用户注册
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/userRegister")
	public String userRegister(HttpServletRequest request,MultipartFile photo) throws Exception{
		Map<String, String[]> map=request.getParameterMap();
		//System.out.println(map);
		User user=new User();
		//获得用户头像
		CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(request.getSession().getServletContext());
		if (multipartResolver.isMultipart(request)) {
			MultipartHttpServletRequest multiRequest= (MultipartHttpServletRequest) request;
			Iterator<String> iter=multiRequest.getFileNames();
			while (iter.hasNext()) {
				photo = multiRequest.getFile((String)iter.next());
				if (photo != null) {
					String realPath="D:/eclipseWorkspace2/ShoppingMall/WebContent/userPhoto/";
					String path = realPath + photo.getOriginalFilename();
					user.setPhoto("userPhoto/"+photo.getOriginalFilename());
					File localFile= new File(path);
					if (!localFile.exists()) {
						localFile.mkdirs();
					}
					photo.transferTo(localFile);
				}
			}
		}
		//工具类 拿到用户数据        
		MyBeanUtils.populate(user, map);
		user.setUid(UUIDUtils.getId());
		user.setState(0);
		user.setCode(UUIDUtils.getCode());
		System.out.println(user);
		try {
			//System.out.println(user);
			userService.insert(user);
			request.setAttribute("msg", "用户注册成功，请激活！");
			//注册成功，向用户发送邮箱信息，跳转到提示页面
			MailUtils.sendMail(user.getEmail(), user.getCode());
		} catch (Exception e) {
			//e.getMessage()
			request.setAttribute("msg","用户注册失败，请重新注册！");
			//注册失败，跳转到提示页面
		}
		return "info";
	}
	
	/**
	 * 激活用户
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/active")
	public ModelAndView active(HttpServletRequest request) {
		ModelAndView mv=new ModelAndView();
		//获取激活码
		String code=request.getParameter("code");
		System.out.println(code);
		//调用业务层激活功能
		boolean flag=userService.active(code);
		//进行激活信息提示
		if (flag==true) {
			//激活成功
			request.setAttribute("msg","激活成功，请登录！");
			mv.setViewName("/login");
		}else{
			//激活失败
			request.setAttribute("msg", "激活失败，请重新激活！");
			mv.setViewName("/info");
		}
		return mv;
	}
	
	@RequestMapping("/login")
	public String login(){
		return "login";
	}
	/**
	 * 用户登录
	 * @param request
	 * @return
	 */
	@RequestMapping("/userLogin")	
	public String userLogin(HttpServletRequest request,Model model ){
		
		//登录 根据用户名密码 登录
		User user=new User();
		//获取数据（账号，密码）
		MyBeanUtils.populate(user, request.getParameterMap());
		User user2=null;
		try {
			//拿到user2的所有信息（user2===user）
			user2=userService.selectLogin(user);
			//model.addAttribute("loginUser", user2);
			request.getSession().setAttribute("loginUser", user2);
			//输入验证码
			String code=request.getParameter("code");
			HttpSession session=request.getSession();
			String picCode=(String) session.getAttribute("picCode");
			if (code.equalsIgnoreCase(picCode)) {
				//重定向到商城首页
				return "redirect:/index.jsp";
			}else{
				request.setAttribute("msg", "请输入验证码");
				return "login";
			}
		} catch (Exception e) {
			String msg=e.getMessage();
			request.setAttribute("msg", msg);
			return "login";
		}
		
	}
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request){
		//清除session
		request.getSession().invalidate();
		//重定向到首页
		return "redirect:/index.jsp";
	}
	
	//转发到用户个人信息页面
	@RequestMapping("/userinfo")
	public String userinfo(HttpSession session,Model model){
		String uid=session.getId();
		//System.out.println(uid);
		User user=userService.selectById(uid);
		//System.out.println(user);
		model.addAttribute("loginUser", user);
		return "userInfo";
	}
	
	//修改个人信息
	@RequestMapping("/modifyUser")
	public String modifyUser(HttpServletRequest request,MultipartFile photo,Model model) throws Exception{
		String uid=request.getParameter("uid");
		//System.out.println(uid);
		User user=new User();
		Map<String,String[]> map=request.getParameterMap();
		BeanUtils.populate(user, map);
		userService.update(user);
		User user2=userService.selectById(uid);
		//修改用户后，用session保存user2
		request.getSession().setAttribute("loginUser", user2);
		//model.addAttribute("loginUser", user2);
		return "redirect:/index.jsp";
	}
	
	/**
	 * 跳转到修改密码的页面
	 */
	@RequestMapping("/modifyPasswordjsp")
	public String modifyPasswordjsp(){
		return "modifyPassword";
	}
	
	/**
	 * 修改密码
	 */
	@RequestMapping("/modifyPassword")
	public String modifyPassword(@RequestParam("uid") String uid,@RequestParam("oldpassword") String oldpassword,
			@RequestParam("newpassword") String newpassword,
			@RequestParam("confirmnewpwd") String confirmnewpwd,Model model){
		//User user=userService.selectById(uid);
		//System.out.println(uid+","+user+","+oldpassword+","+newpassword);
		if (oldpassword.equals(userService.getpassword(uid)) && newpassword.equals(confirmnewpwd)) {
			User user=new User();
			user.setUid(uid);
			user.setPassword(newpassword);
			userService.updatePassword(user);
			model.addAttribute("msg", "修改密码成功！");
			return "redirect:/index.jsp";
			
		}else if (!oldpassword.equals(userService.getpassword(uid))) {
			model.addAttribute("msg", "密码错误！");
			return "modifyPassword";
		}else if (!newpassword.equals(confirmnewpwd)) {
			model.addAttribute("msg", "两次密码不一样！");
			return "modifyPassword";
		}
		
		return "";
	}
	
	/**
	 * 跳转到修改用户头像的页面
	 */
	@RequestMapping("/modifyUserPhotojsp")
	public String modifyUserPhotojsp(HttpSession session,Model model){
		
		return "userPhoto";
	}
	
	/**
	 * 修改用户头像
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	@RequestMapping("/modifyUserPhoto")
	public String modifyUserPhoto(@RequestParam("uid") String uid,HttpServletRequest request,MultipartFile photo,Model model) throws Exception{
		User user=new User();
		CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(request.getSession().getServletContext());
		if (multipartResolver.isMultipart(request)) {
			MultipartHttpServletRequest multiRequest= (MultipartHttpServletRequest) request;
			Iterator<String> iter=multiRequest.getFileNames();
			while (iter.hasNext()) {
				photo = multiRequest.getFile((String)iter.next());
				if (photo!=null) {
					// D:/Tomcat/apache-tomcat-9.0.8/webapps/ShoppingMall/userPhoto
					//String realPath=request.getSession().getServletContext().getRealPath("/userPhoto/");
					String realPath="D:/eclipseWorkspace2/ShoppingMall/WebContent/userPhoto/";
					String path = realPath + photo.getOriginalFilename();
					//user.setPhoto("userPhoto/"+photo.getOriginalFilename());
					File localFile= new File(path);
					if (!localFile.exists()) {
						localFile.mkdirs();
					}
					photo.transferTo(localFile);
				}
			}
		}
		//System.out.println(photo.getOriginalFilename());
		user.setUid(uid);
		user.setPhoto("userPhoto/"+photo.getOriginalFilename());
		//System.out.println(user);			
		userService.updatePhoto(user);
		User user1=userService.selectById(uid);
		//使用session来存用户，以便修改后可以显示修改之后保存到session的用户
		request.getSession().setAttribute("loginUser", user1);
		//model.addAttribute("loginUser", user1);
		return "redirect:/index.jsp";
	}
	
	
}
