<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<HTML>
	<HEAD>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="${pageContext.request.contextPath}/css/Style1.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript">
			function showDetail(oid){
				var $val = $("#but"+oid).val();
				if($val == "订单详情"){
					// ajax 显示图片,名称,单价,数量
					$("#div"+oid).append("<img width='60' height='65' src='${pageContext.request.contextPath}/products/1/c_0028.jpg'>&nbsp;xxxx&nbsp;998<br/>");
					
					$("#but"+oid).val("关闭");
				}else{
					$("#div"+oid).html("");
					$("#but"+oid).val("订单详情");
				}
			}
		</script>
	</HEAD>
	<body>
		<br>
		<form id="Form1" name="Form1" action="${pageContext.request.contextPath}/user/list.jsp" method="post">
			<table cellSpacing="1" cellPadding="0" width="100%" align="center" bgColor="#f5fafe" border="0">
				<TBODY>
					<tr>
						<td class="ta_01" align="center" bgColor="#afd1f3">
							<strong>订单列表</strong>
						</TD>
					</tr>
					
					<tr>
						<td class="ta_01" align="center" bgColor="#f5fafe">
							<table cellspacing="0" cellpadding="1" rules="all"
								bordercolor="gray" border="1" id="DataGrid1"
								style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; BORDER-LEFT: gray 1px solid; WIDTH: 100%; WORD-BREAK: break-all; BORDER-BOTTOM: gray 1px solid; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #f5fafe; WORD-WRAP: break-word">
								<tr
									style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; HEIGHT: 25px; BACKGROUND-COLOR: #afd1f3">

									<td align="center" width="5%">
										序号
									</td>
									<td align="center" width="30%">
										订单编号
									</td>
									<td align="center" width="5%">
										订单金额
									</td>
									<td align="center" width="5%">
										收货人
									</td>
									<td align="center" width="5%">
										订单状态
									</td>
									<td align="center" width="50%">
										订单详情
									</td>
								</tr>
								<c:forEach items="${orders}" var="o" varStatus="status">
										<tr onmouseover="this.style.backgroundColor = 'white'"
											onmouseout="this.style.backgroundColor = '#F5FAFE';">
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="5%">
												${status.count}
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="20%">
												${o.oid}
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="5%">
												${o.total}
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="5%">
												${o.name}
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="5%">
												<c:if test="${o.state==1}">未付款</c:if>
												<c:if test="${o.state==2}">
													<a href="${pageContext.request.contextPath}/updateOrderState?oid=${o.oid}">发货</a>
												</c:if>
												<c:if test="${o.state==3}">已发货</c:if>
												<c:if test="${o.state==4}">订单完成</c:if>
											</td>
											<td align="center" style="HEIGHT: 22px" width="60%">
												<input type="button" value="订单详情" id="${o.oid}" class="myClass"/>
												<table border="1" width="100%">
												   
												</table>
											</td>
										</tr>
										</c:forEach>
							</table>
						</td>
					</tr>
					<tr align="center">
						<td colspan="7">
							
						</td>
					</tr>
				</TBODY>
			</table>
		
			
		</form>
	</body>
	<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(function(){
		
	//页面加载完毕之后,获取样式名称为myClass一批元素,为期绑定点击事件
	$(".myClass").click(function(){
		//获取当前订单id
		var id=this.id;
		//获取当前按钮文字
		var txt=this.value;
		//PS:获取到当前元素的下一个对象table
		var $tb=$(this).next();
		if(txt=="订单详情"){
			//向服务端发送Ajax请求,将当前的订单id传递到服务端
			var url="http://localhost:8080/ShoppingMall/findOrderByOidWithAjax";
			var object={"id":id};
			$.post(url,object,function(data){
				//console.log(data);
				//清除内容
				$tb.html("");
				var th="<tr><th width='25%'>商品</th><th width='25%'>名称</th><th width='25%'>单价</th><th width='25%'>数量</th></tr>";
				$tb.append(th);
				
				//利用JQUERY遍历响应到客户端的数据  
				$.each(data,function(i,obj){
					console.log(obj);
					var td="<tr><td><img src='/ShoppingMall/"+obj.product.pimage+"' width='50px'/></td><td>"+obj.product.pname+"</td><td>"+obj.product.shopPrice+"</td><td>"+obj.quantity+"</td></tr>";
					$tb.append(td);				
				})
			},"json");
			
			this.value="关闭";
			//$(this).val("关闭");
			
		}else{
			this.value="订单详情";
			//清空表格内容
			$tb.html("");
		}
		
		
		
		
	});
});
	</script>
</HTML>

