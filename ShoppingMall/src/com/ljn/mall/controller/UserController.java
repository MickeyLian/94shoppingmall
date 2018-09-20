package com.ljn.mall.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Map;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.jws.soap.SOAPBinding.Use;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
		char ch[]="abcdefghijk123456789".toCharArray();
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
	public String userRegister(HttpServletRequest request) throws Exception{
		Map<String, String[]> map=request.getParameterMap();
		User user=new User();
		//工具类 拿到用户数据
		MyBeanUtils.populate(user, map);
		user.setUid(UUIDUtils.getId());
		user.setState(0);
		user.setCode(UUIDUtils.getCode());
		//System.out.println(user);
		try {
			//System.out.println(user);
			userService.insert(user);
			request.setAttribute("msg", "用户注册成功，请激活！");
			//注册成功，向用户发送邮箱信息，跳转到提示页面
			MailUtils.sendMail(user.getEmail(), user.getCode());
		} catch (Exception e) {
			request.setAttribute("msg", "用户注册失败，请重新注册！");
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
	public String userLogin(HttpServletRequest request){
		User user=new User();
		//获取数据（账号，密码）
		MyBeanUtils.populate(user, request.getParameterMap());
		User user2=null;
		try {
			//拿到user2的所有信息（user2===user）
			user2=userService.selectLogin(user);
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
}
