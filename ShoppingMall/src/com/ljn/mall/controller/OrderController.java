package com.ljn.mall.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.ljn.mall.domain.Cart;
import com.ljn.mall.domain.CartItem;
import com.ljn.mall.domain.Orderitem;
import com.ljn.mall.domain.Orders;
import com.ljn.mall.domain.User;
import com.ljn.mall.service.IOrderService;
import com.ljn.mall.utils.PageModel;
import com.ljn.mall.utils.PaymentUtil;
import com.ljn.mall.utils.UUIDUtils;

import net.sf.json.JSONArray;

@Controller
@SessionAttributes("cart")
public class OrderController {

	@Autowired
	IOrderService orderService;

	/**
	 * 将购物车的信息以订单的形式保存
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/saveOrder")
	public String saveOrder(HttpServletRequest request) {
		// 确认用户登录状态
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");
		if (user == null) {
			request.setAttribute("msg", "请先登录再访问！");
			return "info";
		}
		// 获取购物车
		Cart cart = (Cart) session.getAttribute("cart");
		// 创建订单对象，为订单对象赋值
		Orders orders = new Orders();
		orders.setOid(UUIDUtils.getId());
		orders.setOrdertime(new Date());
		orders.setTotal(cart.getTotal());
		orders.setState(1);
		orders.setUser(user);
		// 遍历购物车的同时，创建订单项，为订单项赋值
		for (CartItem item : cart.getCartItems()) {
			Orderitem orderitem = new Orderitem();
			orderitem.setItemid(UUIDUtils.getId());
			orderitem.setQuantity(item.getNum());
			orderitem.setTotal(item.getSubTotal());
			orderitem.setProduct(item.getProduct());
			orderitem.setOrders(orders);
			orders.getList().add(orderitem);
		}
		// 调用业务层功能：saveOrder（）
		orderService.saveOrder(orders);
		// 清空购物车
		cart.clearCart();
		// 将订单放入request
		request.setAttribute("order", orders);
		// 转发到order_info.jsp页面
		return "order_info";
	}

	/**
	 * 分页查询我的订单
	 * 
	 * @param request
	 * @param curPage
	 * @param model
	 * @return
	 */
	@RequestMapping("/findMyOrderWithPage")
	public String findMyOrderWithPage(HttpServletRequest request, @RequestParam(value = "curPage") int curPage,
			Model model) {
		// 获取用户信息
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");
		// 获取当前页
		// 调用业务层：查询当前用户订单信息，返回PageModel
		PageModel pm = orderService.findMyOrderWithPage(curPage, user);
		// select * from orders where uid=? limit 当前页，页数
		// 将PageModel放入request
		model.addAttribute("page", pm);
		// 转发到/jsp/order_list.jsp
		return "order_list";
	}

	/**
	 * 进入订单详情
	 * 
	 * @param oid
	 * @param model
	 * @return
	 */
	@RequestMapping("/findOrderByOid")
	public String findOrderByOid(@RequestParam("oid") String oid, Model model) {
		Orders order = orderService.findOrderByOid(oid);
		model.addAttribute("order", order);
		return "order_info";
	}

	/**
	 * 取消订单
	 * 
	 * @param oid
	 * @return
	 */
	@RequestMapping("/deleteOrderByoid")
	public String deleteOrderByoid(@RequestParam("oid") String oid, HttpServletRequest request,
			@RequestParam(value = "curPage") int curPage, Model model) {
		orderService.deleteOrderByoid(oid);
		// 获取用户信息
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");
		// 获取当前页
		// 调用业务层：查询当前用户订单信息，返回PageModel
		PageModel pm = orderService.findMyOrderWithPage(curPage, user);
		// select * from orders where uid=? limit 当前页，页数
		// 将PageModel放入request
		model.addAttribute("page", pm);
		return "order_list";
	}

	@RequestMapping("/payOrder")
	public String payOrder(@RequestParam("oid") String oid, @RequestParam("address") String address,
			@RequestParam("name") String name, @RequestParam("telephone") String telephone,
			@RequestParam("pd_FrpId") String pd_FrpId) {
		// 获取订单oid,收货人地址,姓名,电话,银行
		// 更新订单上收货人的地址,姓名,电话
		Orders order = orderService.findOrderByOid(oid);
		order.setName(name);
		order.setTelephone(telephone);
		order.setAddress(address);
		orderService.updateOrder(order);
		// 向易宝支付发送参数
		// 把付款所需要的参数准备好:
		String p0_Cmd = "Buy";
		// 商户编号
		String p1_MerId = "10001126856";
		// 订单编号
		String p2_Order = oid;
		// 金额
		String p3_Amt = "0.01"; // order.getTotal()
		String p4_Cur = "CNY";
		String p5_Pid = "";
		String p6_Pcat = "";
		String p7_Pdesc = "";
		// 接受响应参数的Servlet
		String p8_Url = "http://localhost:8080/ShoppingMall/callBack";
		String p9_SAF = "";
		String pa_MP = "";
		String pr_NeedResponse = "1";
		// 公司的秘钥
		String keyValue = "69cl522AV6q613Ii4W6u8K6XuW8vM1N6bFgyv769220IuYe9u37N4y7rI4Pl";

		// 调用易宝的加密算法,对所有数据进行加密,返回电子签名
		String hmac = PaymentUtil.buildHmac(p0_Cmd, p1_MerId, p2_Order, p3_Amt, p4_Cur, p5_Pid, p6_Pcat, p7_Pdesc,
				p8_Url, p9_SAF, pa_MP, pd_FrpId, pr_NeedResponse, keyValue);

		StringBuffer sb = new StringBuffer("https://www.yeepay.com/app-merchant-proxy/node?");
		sb.append("p0_Cmd=").append(p0_Cmd).append("&");
		sb.append("p1_MerId=").append(p1_MerId).append("&");
		sb.append("p2_Order=").append(p2_Order).append("&");
		sb.append("p3_Amt=").append(p3_Amt).append("&");
		sb.append("p4_Cur=").append(p4_Cur).append("&");
		sb.append("p5_Pid=").append(p5_Pid).append("&");
		sb.append("p6_Pcat=").append(p6_Pcat).append("&");
		sb.append("p7_Pdesc=").append(p7_Pdesc).append("&");
		sb.append("p8_Url=").append(p8_Url).append("&");
		sb.append("p9_SAF=").append(p9_SAF).append("&");
		sb.append("pa_MP=").append(pa_MP).append("&");
		sb.append("pd_FrpId=").append(pd_FrpId).append("&");
		sb.append("pr_NeedResponse=").append(pr_NeedResponse).append("&");
		sb.append("hmac=").append(hmac);

		System.out.println(sb.toString());
		// 使用重定向：
		// resp.sendRedirect(sb.toString());
		return "redirect:" + sb.toString();
	}

	@RequestMapping("/callBack")
	public String callback(@RequestParam("p1_MerId") String p1_MerId, Model model,
			@RequestParam("r0_Cmd") String r0_Cmd, @RequestParam("r1_Code") String r1_Code,
			@RequestParam("r2_TrxId") String r2_TrxId, @RequestParam("r3_Amt") String r3_Amt,
			@RequestParam("r4_Cur") String r4_Cur, @RequestParam("r5_Pid") String r5_Pid,
			@RequestParam("r6_Order") String r6_Order, @RequestParam("r7_Uid") String r7_Uid,
			@RequestParam("r8_MP") String r8_MP, @RequestParam("r9_BType") String r9_BType,
			@RequestParam("rb_BankId") String rb_BankId, @RequestParam("ro_BankOrderId") String ro_BankOrderId,
			@RequestParam("rp_PayDate") String rp_PayDate, @RequestParam("rq_CardNo") String rq_CardNo,
			@RequestParam("ru_Trxtime") String ru_Trxtime, @RequestParam("hmac") String hmac,
			HttpServletResponse response) {
		// 接收易宝支付的数据
		// 验证请求来源和数据有效性
		// 阅读支付结果参数说明
		// System.out.println("==============================================");
		// 利用本地密钥和加密算法 加密数据
		String keyValue = "69cl522AV6q613Ii4W6u8K6XuW8vM1N6bFgyv769220IuYe9u37N4y7rI4Pl";

		// 保证数据合法性
		boolean isValid = PaymentUtil.verifyCallback(hmac, p1_MerId, r0_Cmd, r1_Code, r2_TrxId, r3_Amt, r4_Cur, r5_Pid,
				r6_Order, r7_Uid, r8_MP, r9_BType, keyValue);
		if (isValid) {
			// 有效
			if (r9_BType.equals("1")) {
				// 浏览器重定向
				// 如果支付成功,更新订单状态
				Orders order = orderService.findOrderByOid(r6_Order);
				order.setState(2);
				orderService.updateOrder(order);
				// 向model放入提示信息
				model.addAttribute("msg", "支付成功！订单号：" + r6_Order + "金额：" + r3_Amt);
				// 转发到/jsp/info.jsp
				return "info";

			} else if (r9_BType.equals("2")) {
				// 修改订单状态:
				// 服务器点对点，来自于易宝的通知
				System.out.println("收到易宝通知，修改订单状态！");//
				// 回复给易宝success，如果不回复，易宝会一直通知
				try {
					response.getWriter().print("success");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		} else {
			throw new RuntimeException("数据被篡改！");
		}
		return null;
	}
	
	//后台
	@RequestMapping("/findOrders")
	public String findOrders(HttpServletRequest request,Model model){
		String state=request.getParameter("state");
		List<Orders> list=null;
		if (state==null||"".equals(state)) {
			list=orderService.findOrders();
		}else{
			list=orderService.findOrdersWithState(state);
		}
		model.addAttribute("orders", list);
		return "forward:/admin/order/list.jsp";
	}
	@RequestMapping("/findOrderByOidWithAjax")
	@ResponseBody
	public String findOrderByOidWithAjax(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String oid=request.getParameter("id");
		Orders orders=orderService.findOrderByOid(oid);
		//将返回的集合转换为JSON格式字符串,响应到客户端
		String jsonStr=JSONArray.fromObject(orders.getList()).toString();
		//响应到客户端
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().println(jsonStr);
		//System.out.println(orders);
		return null;
	}
	@RequestMapping("/updateOrderState")
	public String updateOrderState(@RequestParam("oid") String oid) {
		Orders orders=orderService.findOrderByOid(oid);
		orders.setState(3);
		orderService.updateOrder(orders);
		return "redirect:/findOrders?state=3";
	}
}
